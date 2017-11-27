------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert employees data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_employees
AS
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
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
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_select VARCHAR2(1050);
  acc             NUMBER(8);
  acc_err         NUMBER(8);
  CURSOR c_data
  IS
    SELECT code,surname, name, phone, email FROM wrk_employees ;
type t__data
IS
  TABLE OF c_data%rowtype;
  t_data t__data;
BEGIN
  acc            :=0;
  acc_err        :=0;
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  EXECUTE immediate sql_stmt_trunc||'_error';
  dbms_output.put_line('Table '|| target_table_cls||'_error'||' is successfully truncated.');
  drop_seq('seq_emp');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_EMP INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FOR i IN t_data.first .. t_data.last
    LOOP
      IF t_data(i).surname IS NULL OR t_data(i).name IS NULL THEN
        INSERT
        INTO cls_employees_error VALUES
          (
            t_data(i).code,
            t_data(i).surname,
            t_data(i).name,
            t_data(i).phone,
            t_data(i).email
          );
        acc_err := acc_err+ SQL%ROWCOUNT;
      ELSE
        INSERT INTO cls_employees
          (emp_src_id,code,surname,name,phone,email
          )
        SELECT seq_emp.nextval,
          code,
          sur,
          n,
          phone,
          email
        FROM
          (SELECT DISTINCT t_data(i).code code,
            INITCAP(t_data(i).surname) sur,
            INITCAP(t_data(i).name) n,
            NVL(t_data(i).phone,'N/D') phone,
            NVL(LOWER(t_data(i).email),'N/D') email
          FROM wrk_employees
          );
        acc := acc + SQL%ROWCOUNT;
      END IF;
    END LOOP;
  END LOOP;
  dbms_output.put_line('Data is successfully loaded in the table '||target_table_cls||' : '||acc|| ' rows were inserted.');
  dbms_output.put_line('Corrupted data is successfully loaded in the table '||target_table_cls||'_error : '||acc_err|| ' rows were inserted.');
  CLOSE c_data;
  /********************generate*********************/
  /************************************************/
  MERGE INTO cls_employees cls USING
  (SELECT code FROM cls_employees
  ) dep ON (dep.code = cls.code)
WHEN MATCHED THEN
  UPDATE
  SET cls.dep_id = (ABS(ROUND(dbms_random.normal()*4))+1),
    cls.man_id   = randomize_man_id;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_employees;
/

EXECUTE pckg_insert_employees.insert_bl_wrk(source_table=>'src.ext_employee', target_table_wrk=>'wrk_employees');
EXECUTE pckg_insert_employees.insert_bl_cls(source_table_wrk=>'wrk_employees', target_table_cls=>'cls_employees');
SELECT * FROM cls_employees
order by emp_src_id;