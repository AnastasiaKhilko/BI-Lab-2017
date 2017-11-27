------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert address data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_genre
AS
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table     IN VARCHAR2,
      target_table_cls IN VARCHAR2);
      PROCEDURE insert_bl_3NF;
END pckg_insert_genre;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_genre
AS
PROCEDURE drop_seq(
    Object_Name IN VARCHAR2)
IS
  ex_seq EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_seq, -02289);
BEGIN
  EXECUTE immediate 'drop sequence ' || Object_Name;
EXCEPTION
WHEN ex_seq THEN
  dbms_output.put_line('does not exist');
WHEN OTHERS THEN
  RAISE;
END;
/*************SRC->CLS****************/
/*************************************/
PROCEDURE insert_bl_cls(
    source_table     IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT SEQ_GENRE.NEXTVAL, GENRE FROM (SELECT DISTINCT GENRE FROM '|| source_table||' WHERE GENRE IS NOT NULL)';
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  drop_seq('seq_genre');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_GENRE INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_bl_cls;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
MERGE INTO bl_3nf.ce_genres ce USING
  ( SELECT genre_src_id, genre_name FROM cls_genre
  MINUS
  SELECT genre_code,genre_name
  FROM bl_3nf.ce_genres
  ) cls ON ( cls.genre_src_id = ce.genre_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.genre_name     = cls.genre_name,
    ce.update_dt         =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      genre_id ,
      genre_CODE ,
      genre_name
    )
    VALUES
    (
      seq_genre_3nf.nextval ,
      cls.genre_src_id,
      cls.genre_name
    ) ;
    END;
END pckg_insert_genre;
/
EXECUTE pckg_insert_genre.insert_bl_cls(source_table=>'src.ext_catalog', target_table_cls=>'cls_genre');
SELECT * FROM cls_genre;
EXECUTE pckg_insert_genre.insert_bl_3nf;
SELECT * FROM bl_3nf.ce_genres;
CREATE SEQUENCE SEQ_GENRE INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
CREATE SEQUENCE SEQ_GENRE_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;