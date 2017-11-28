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
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
   PROCEDURE insert_bl_3NF;
END pckg_insert_store;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_store
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
  INSERT INTO cls_stores (code, name, phone, address_id,manager_id)
  SELECT DISTINCT 
      code,
      name,
      ROUND(dbms_random.value(100000,999999)) phone,
      addr_id addr,
      ROUND(dbms_random.value(250,450))
      FROM wrk_stores wrk
      INNER JOIN cls_addr cls
      ON wrk.street=cls.addr_street and wrk.number_house=cls.addr_number_house
      INNER JOIN bl_3nf.ce_addr ce
      ON cls.addr_code=ce.addr_code;
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
MERGE INTO bl_3nf.ce_stores ce USING
( SELECT code,name,phone,address_id,manager_id FROM cls_stores
MINUS
SELECT store_code,
  store_name,
  store_phone,
  store_address_id,
  store_manager_id
FROM bl_3nf.ce_stores

) cls ON ( cls.code = ce.store_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.store_name     = cls.name,
    ce.store_phone      = cls.phone,
    ce.store_manager_id = cls.manager_id,
    ce.store_address_id = cls.address_id,
    ce.update_dt        =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      store_id ,
      store_code,
      store_name,
      store_phone,
      store_manager_id,
      store_address_id
    )
    VALUES
    (
      seq_stores_3nf.nextval ,
      cls.code,
      cls.name ,
      cls.phone,
      cls.manager_id,
      cls.address_id
    ) ; 
COMMIT;
    END;
END pckg_insert_store;
/
EXECUTE pckg_insert_store.insert_bl_wrk(source_table=>'src.ext_shop_chit_gorod', target_table_wrk=>'wrk_stores');
SELECT * FROM wrk_stores;
EXECUTE pckg_insert_store.insert_bl_cls(source_table_wrk=>'wrk_stores', target_table_cls=>'cls_stores');
SELECT * FROM cls_stores;
EXECUTE pckg_insert_store.insert_bl_3nf;
select *  from bl_3nf.ce_stores
order by store_id;
CREATE SEQUENCE SEQ_STORES_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
