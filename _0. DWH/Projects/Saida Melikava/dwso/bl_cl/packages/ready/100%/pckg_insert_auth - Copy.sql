------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Extract author data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_auth
AS
  PROCEDURE insert_bl_cls(
      source_table     IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_auth;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_auth
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
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT SEQ_AUTH.NEXTVAL, A FROM (SELECT DISTINCT AUTHOR_NAME A FROM '|| source_table||' WHERE AUTHOR_NAME IS NOT NULL)';
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE immediate 'DROP SEQUENCE SEQ_AUTH';
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_AUTH INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
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
MERGE INTO bl_3nf.ce_authors ce USING
  ( SELECT author_code, author_name FROM cls_authors
  MINUS
  SELECT author_code,author_name
  FROM bl_3nf.ce_authors
  ) cls ON ( cls.author_code = ce.author_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.author_name     = cls.author_name,
    ce.update_dt         =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      author_id ,
      author_code ,
      author_name
    )
    VALUES
    (
      seq_auth_3nf.nextval ,
      cls.author_code,
      cls.author_name
    ) ;
    COMMIT;
    END;
END pckg_insert_auth;
/
EXECUTE pckg_insert_auth.insert_bl_cls(source_table=>'src.ext_catalog', target_table_cls=>'cls_authors');
SELECT * FROM cls_authors;
EXECUTE pckg_insert_auth.insert_bl_3nf;
SELECT *   FROM bl_3nf.ce_authors;
CREATE SEQUENCE SEQ_AUTH INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
CREATE SEQUENCE SEQ_AUTH_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;