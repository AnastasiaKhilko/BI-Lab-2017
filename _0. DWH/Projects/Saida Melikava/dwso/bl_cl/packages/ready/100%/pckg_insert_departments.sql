------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Extrzct data about departments from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_dep
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_dep;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_dep
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
  dbms_output.put_line('Table '||target_table_wrk||'is successfully truncated');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
--********WRK->CLS************--
--*****************************--
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  INSERT INTO cls_departments
  SELECT DISTINCT dep_code code, dep_name dname FROM wrk_departments;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
MERGE INTO bl_3nf.ce_departments ce USING
( SELECT dep_code,dep_name FROM cls_departments
MINUS
SELECT department_code, department_name
FROM bl_3nf.ce_departments
) cls 
ON ( cls.dep_code= ce.department_code )
WHEN MATCHED THEN
  UPDATE
  SET 
   
    ce.department_name = cls.dep_name,
    ce.update_dt                =sysdate
    WHEN NOT MATCHED THEN
  INSERT
    (
      department_id,
     department_code,
     department_name
          )
    VALUES
    (
      seq_dep_3nf.nextval ,
      cls.dep_code,
      cls.dep_name
    ) ;
    end;
END pckg_insert_dep;
/

EXECUTE pckg_insert_dep.insert_bl_wrk(source_table=>'src.ext_departments', target_table_wrk=>'wrk_departments');
SELECT * FROM wrk_departments;
EXECUTE pckg_insert_dep.insert_bl_cls(source_table_wrk=>'wrk_departments', target_table_cls=>'cls_departments');
SELECT * FROM cls_departments;
EXECUTE pckg_insert_dep.insert_bl_3nf;
select * from bl_3nf.ce_departments;
CREATE SEQUENCE SEQ_DEP_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;