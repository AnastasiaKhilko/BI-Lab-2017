------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert employees data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_employees
AS
  FUNCTION randomize_man_id
    RETURN NUMBER;
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
END pckg_insert_employees;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_employees
AS
FUNCTION randomize_man_id
  RETURN NUMBER
IS
  i NUMBER(11,2);
  a NUMBER (8,2);
BEGIN
  i:=dbms_random.value(1,10);
  a:=
  CASE
  WHEN i<=8 THEN
    ROUND(dbms_random.value(140,663))
  WHEN i>8 THEN
    '-99'
  END ;
  RETURN(a);
END;
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
  dbms_output.put_line('Table '|| target_table_wrk||' is successfully truncated.');
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_wrk||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/*************WRK->CLS****************/
/*************************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  INSERT INTO cls_employees
    (code, surname, name, phone, email,dep_id,man_id
    )
  SELECT DISTINCT code code,
    INITCAP(surname) sur,
    INITCAP(name) n,
    NVL(phone,'N/D') phone,
    NVL(LOWER(email),'N/D') email,
    ABS(ROUND(dbms_random.normal()*4))+1,
    randomize_man_id
  FROM wrk_employees ;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
 
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_employees;
/
EXECUTE pckg_insert_employees.insert_bl_wrk(source_table=>'src.ext_employee', target_table_wrk=>'wrk_employees');
EXECUTE pckg_insert_employees.insert_bl_cls(source_table_wrk=>'wrk_employees', target_table_cls=>'cls_employees');
SELECT * FROM cls_employees;