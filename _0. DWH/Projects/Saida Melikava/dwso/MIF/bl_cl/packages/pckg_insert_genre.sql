------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert address data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_genre
AS
  PROCEDURE insert_bl_cls(
      source_table     IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_genre;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_genre
AS
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
  EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_GENRE';
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
  ( 
    SELECT genre_code, genre_name FROM cls_genre
    MINUS
    SELECT genre_code,genre_name
    FROM bl_3nf.ce_genres
  ) cls 
  ON ( cls.genre_code = ce.genre_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.genre_name=cls.genre_name,
    ce.update_dt=sysdate 
WHEN NOT MATCHED THEN
  INSERT
    (
      genre_id ,
      genre_code ,
      genre_name
    )
    VALUES
    (
      seq_genre_3nf.nextval ,
      cls.genre_code,
      cls.genre_name
    ) ;
COMMIT;
    END;
END pckg_insert_genre;
/



