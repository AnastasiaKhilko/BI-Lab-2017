------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert data about departments from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_cat_print
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_cat_print;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_cat_print
AS
  /*************SRC->WRK****************/
  /*************************************/
PROCEDURE insert_bl_wrk(
    source_table     IN VARCHAR2,
    target_table_wrk IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_wrk;
  sql_stmt_insert:='INSERT INTO '|| target_table_wrk||' SELECT * FROM '|| source_table;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '||target_table_wrk||' is successfully truncated');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/********wrk->cls*************/
/*****************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(1050);
  sql_stmt_select VARCHAR2(1050);
  acc             NUMBER(8);
  acc_err         NUMBER(8);
  cat_id          NUMBER(8);
  na              NUMBER(8);
  CURSOR c_data
  IS
    SELECT isbn,
      book_name,
      author_name,
      description,
      genre,
      weight
    FROM wrk_catalog_print ;
type t__data
IS
  TABLE OF c_data%rowtype;
  t_data t__data;
BEGIN
  acc     :=0;
  acc_err :=0;
  cat_id  :=1;
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE immediate sql_stmt_trunc||'_error';
  dbms_output.put_line('Table '|| target_table_cls||'_error is successfully truncated.');
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FOR i IN t_data.first .. t_data.last
    LOOP
      IF t_data(i).author_name IS NULL OR t_data(i).isbn IS NULL OR t_data(i).genre IS NULL THEN
        INSERT
        INTO cls_catalog_error VALUES
          (
            t_data(i).isbn,
            t_data(i).book_name,
            t_data(i).author_name,
            t_data(i).description,
            t_data(i).genre,
            t_data(i).weight
          );
        acc_err := acc_err+ SQL%ROWCOUNT;
      ELSE
        INSERT INTO cls_catalog
        SELECT DISTINCT 
            t_data(i).isbn isbn,
            '1',
            t_data(i).book_name bname,
            author_id auth,
            NVL(t_data(i).description, 'N/D') d,
            genre_id g,
            to_number(t_data(i).weight,'9999.99') w
          FROM wrk_catalog_print wrk
          inner join cls_authors cls1
          on t_data(i).author_name=cls1.author_name
          inner join cls_genre cls2
          on t_data(i).genre=cls2.genre_name
          inner join bl_3nf.ce_authors ce1
          on ce1.author_code=cls1.author_code
          inner join bl_3nf.ce_genres ce2
          on ce2.genre_code=cls2.genre_code
          ;
        acc := acc + SQL%ROWCOUNT;
      END IF;
    END LOOP;
  END LOOP;
  dbms_output.put_line('Data is successfully loaded in the table '||target_table_cls||' : '||acc|| ' rows were inserted.');
  dbms_output.put_line('Corrupted data is successfully loaded in the table '||target_table_cls||'_error : '||acc_err|| ' rows were inserted.');
  CLOSE c_data;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_bl_cls;
/********cls->3NF *************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
MERGE INTO bl_3nf.ce_catalog ce USING
(SELECT 
  isbn,
  cat_id,
  book_name,
  author_id,
  description,
  genre_id,
  weight_kg
FROM cls_catalog
MINUS
SELECT 
  prod_code,
  prod_category_id,
  prod_name,
  prod_author_id,
  prod_description,
  prod_genre_id,
  prod_weight_kg
FROM bl_3nf.ce_catalog
) cls ON ( cls.isbn = ce.prod_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.prod_category_id = cls.cat_id,
    ce.prod_name          = cls.book_name,
    ce.prod_author_id     = cls.author_id,
    ce.prod_description   = cls.description,
    ce.prod_genre_id      = cls.genre_id,
    ce.prod_weight_kg     = cls.weight_kg,
    ce.update_dt          =sysdate 
  WHEN NOT MATCHED THEN
  INSERT
    (
      Prod_id ,
      Prod_code ,
      Prod_category_id ,
      Prod_name ,
      Prod_author_id ,
      Prod_description ,
      Prod_genre_id ,
      Prod_weight_kg
    )
    VALUES
    (
      seq_cat_3nf.nextval ,
      cls.isbn,
      cls.cat_id,
      cls.book_name,
      cls.author_id,
      cls.description,
      cls.genre_id,
      cls.weight_kg
    ) ;
    COMMIT;
    END;
END pckg_insert_cat_print;
/





