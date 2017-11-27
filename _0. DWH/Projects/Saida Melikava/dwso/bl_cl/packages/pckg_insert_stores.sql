------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert data about departments from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_store
AS
  PROCEDURE insert_bl_wrk(
      source_table     IN VARCHAR2,
      target_table_wrk IN VARCHAR2);
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
END pckg_insert_store;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_store
AS
PROCEDURE drop_seq(
    Object_Name IN VARCHAR2)
IS
  ex_seq EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_seq, -02289);
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
  sql_stmt_insert VARCHAR2(250);
BEGIN
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  drop_seq('seq_stores');
  dbms_output.put_line('dropped.');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_STORES INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  INSERT INTO cls_stores
    (store_src_id,code,name,phone, address
    )
  SELECT seq_stores.nextval,
    code,
    name,
    phone,
    addr
  FROM
    (SELECT DISTINCT code,
      name,
      ROUND(dbms_random.value(100000,999999)) phone,
      street
      ||' '
      ||number_house addr
    FROM wrk_stores
    );
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  /**********generation*********/
  /****************************/
  MERGE INTO cls_stores cls USING
  (SELECT n
  FROM
    (SELECT level n FROM dual CONNECT BY level <=
      (SELECT COUNT(*) FROM cls_stores
) )
  ) man ON (cls.store_src_id = man.n)
WHEN MATCHED THEN
  UPDATE SET cls.manager_id = ROUND(dbms_random.value(250,450));
  
   MERGE INTO cls_employees cls USING
  (SELECT n
  FROM
    (SELECT level n FROM dual CONNECT BY level <=
      (SELECT COUNT(*) FROM cls_employees
) )
  ) man ON (cls.emp_src_id = man.n)
WHEN MATCHED THEN
  UPDATE SET cls.store_id = ceil(abs(dbms_random.normal()*80));
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_store;
/
EXECUTE pckg_insert_store.insert_bl_wrk(source_table=>'src.ext_shop_chit_gorod', target_table_wrk=>'wrk_stores');
SELECT * FROM wrk_stores;
EXECUTE pckg_insert_store.insert_bl_cls(source_table_wrk=>'wrk_stores', target_table_cls=>'cls_stores');
SELECT * FROM cls_employees
order by store_id;
CREATE SEQUENCE SEQ_STORES INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
