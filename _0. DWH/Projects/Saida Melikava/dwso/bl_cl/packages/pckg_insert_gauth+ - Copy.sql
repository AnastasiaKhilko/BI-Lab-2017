------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert author data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_auth
AS
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table     IN VARCHAR2,
      target_table_cls IN VARCHAR2);
END pckg_insert_auth;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_auth
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
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT SEQ_AUTH.NEXTVAL, A FROM (SELECT DISTINCT AUTHOR_NAME A FROM '|| source_table||' WHERE AUTHOR_NAME IS NOT NULL)';
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  drop_seq('seq_auth');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_AUTH INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  EXECUTE immediate sql_stmt_insert;
  EXECUTE immediate 'INSERT INTO '||target_table_cls||q'< VALUES('-99', 'N/D')>';
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_bl_cls;
END pckg_insert_auth;
/
EXECUTE pckg_insert_auth.insert_bl_cls(source_table=>'src.ext_catalog', target_table_cls=>'cls_authors');
SELECT * FROM cls_authors;
CREATE SEQUENCE SEQ_AUTH INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;