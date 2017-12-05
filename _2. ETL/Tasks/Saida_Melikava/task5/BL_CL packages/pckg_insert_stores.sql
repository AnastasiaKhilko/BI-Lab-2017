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
  INSERT INTO cls_stores(code,name,phone,address_id,manager_id,start_dt, end_dt)
select wrk.code, wrk.name,wrk.phone,addr_id,round(dbms_random.value(250,450)),
nvl2(ce.store_code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt, 
TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
from wrk_stores wrk
INNER JOIN cls_addr cls
ON wrk.street=cls.addr_street and wrk.number_house=cls.addr_number_house
INNER JOIN bl_3nf.ce_addr ce1
ON cls.addr_code=ce1.addr_code
left join bl_3nf.ce_stores ce
ON (ce.start_dt<= TRUNC(sysdate)
and ce.end_dt > TRUNC(sysdate)
and ce.store_code = wrk.code)
WHERE DECODE(wrk.name,ce.store_name,0,1)+DECODE(wrk.phone,ce.store_phone,0,1)
+DECODE(addr_id,ce.store_address_id,0,1)>0
and wrk.code is not null
union all
select ce.store_code, ce.store_name,ce.store_phone, ce.store_address_id,ce.store_manager_id,ce.start_dt, TRUNC(sysdate) end_dt
from wrk_stores wrk
INNER JOIN cls_addr cls
ON wrk.street=cls.addr_street and wrk.number_house=cls.addr_number_house
INNER JOIN bl_3nf.ce_addr ce1
ON cls.addr_code=ce1.addr_code
join bl_3nf.ce_stores ce 
ON (ce.start_dt<= TRUNC(sysdate)
and ce.end_dt > TRUNC(sysdate)
and ce.store_code = wrk.code)
where DECODE(wrk.name,ce.store_name,0,1)+DECODE(wrk.phone,ce.store_phone,0,1)
+DECODE(addr_id,ce.store_address_id,0,1)>0
and wrk.code is not null;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
--********CLS->3NF************--
--*****************************--
PROCEDURE insert_bl_3NF
IS
BEGIN
MERGE INTO bl_3nf.ce_stores ce
USING (SELECT * FROM cls_stores) cls
ON (cls.code = ce.store_code 
AND cls.start_dt = ce.start_dt)
WHEN MATCHED THEN 
UPDATE SET 
ce.store_name=cls.name,
ce.store_phone=cls.phone,
ce.store_manager_id=cls.manager_id,
ce.store_address_id=cls.address_id,
ce.end_dt=cls.end_dt
WHEN NOT MATCHED THEN 
INSERT (store_id,store_code,store_name,store_phone,store_manager_id,store_address_id,start_dt, end_dt)
VALUES (seq_store_3nf.nextval,cls.code, cls.name, cls.phone,cls.manager_id, cls.address_id, cls.start_dt,cls.end_dt);
COMMIT;
end;
END pckg_insert_store;
/


