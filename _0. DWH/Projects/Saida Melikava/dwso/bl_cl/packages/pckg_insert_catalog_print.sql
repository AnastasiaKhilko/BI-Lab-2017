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
  na      :=-99;
  /*  sql_stmt_select:= q'<
  (SELECT DISTINCT isbn,book_name,author_name,description, genre, weight FROM wrk_catalog_print)
  >';*/
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE immediate sql_stmt_trunc||'_error';
  dbms_output.put_line('Table '|| target_table_cls||'_error is successfully truncated.');
  /* drop_seq('seq_cat_print');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_CAT_PRINT INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';*/
  dbms_output.put_line('New sequence is created.');
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FOR i IN t_data.first .. t_data.last
    LOOP
      IF t_data(i).author_name IS NULL THEN
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
        SELECT seq_cat_print.nextval,
          isbn,
          cat_id,
          bname,
          auth,
          d,
          g,
          w,
          na,
          na
        FROM
          (SELECT DISTINCT t_data(i).isbn isbn,
            t_data(i).book_name bname,
            INITCAP(t_data(i).author_name) auth,
            NVL(t_data(i).description, 'N/D') d,
            t_data(i).genre g,
            to_number(t_data(i).weight,'9999.99') w
          FROM wrk_catalog_print
          );
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
END pckg_insert_cat_print;
/
EXECUTE pckg_insert_cat_print.insert_bl_wrk(source_table=>'src.ext_catalog', target_table_wrk=>'wrk_catalog_print');
SELECT * FROM wrk_catalog_print;
EXECUTE pckg_insert_cat_print.insert_bl_cls(source_table_wrk=>'wrk_catalog_print', target_table_cls=>'cls_catalog');
SELECT * FROM cls_catalog;
CREATE SEQUENCE SEQ_CAT_PRINT INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;