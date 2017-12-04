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
  PROCEDURE insert_bl_3NF;
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
    (code, surname, name, phone, email,dep_id,man_id,store_id
    )
  SELECT DISTINCT code code,
    INITCAP(surname) sur,
    INITCAP(name) n,
    NVL(phone,'N/D') phone,
    NVL(LOWER(email),'N/D') email,
    ABS(CEIL(dbms_random.normal()*4))+1,
    randomize_man_id,
    ABS(CEIL(dbms_random.normal()*65))+1
  FROM wrk_employees ;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/*************CLS->3NF****************/
/*************************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
  MERGE INTO bl_3nf.ce_employees ce USING
  (SELECT 
    code,
    surname,
    name,
    phone,
    email,
    dep_id,
    man_id,
    store_id
  FROM cls_employees
  MINUS
  SELECT 
    employee_code,
    employee_surname,
    employee_name,
    employee_phone,
    employee_email,
    employee_dep_id,
    employee_manager_id,
    employee_store_id
  FROM bl_3nf.ce_employees
  ) cls ON ( cls.code = ce.employee_code )
WHEN MATCHED THEN
  UPDATE
  SET 
    ce.employee_surname=cls.surname,
    ce.employee_name=cls.name,
    ce.employee_phone=cls.phone,
    ce.employee_email=cls.email,
    ce.employee_dep_id=cls.dep_id,
    ce.employee_manager_id=cls.man_id,
    ce.employee_store_id=cls.store_id,
    ce.update_dt        =TRUNC(sysdate) 
    WHEN NOT MATCHED THEN
  INSERT
    (
    ce.employee_id,
    ce.employee_code,
    ce.employee_surname,
    ce.employee_name,
    ce.employee_phone,
    ce.employee_email,
    ce.employee_dep_id,
    ce.employee_manager_id,
    ce.employee_store_id

    )
    VALUES
    (
      seq_emp_3nf.nextval,
      cls.code,
      cls.surname,
      cls.name,
      cls.phone,
      cls.email,
      cls.dep_id,
      cls.man_id,
      cls.store_id
    ) ;
  COMMIT;
END;
END pckg_insert_employees;
/




