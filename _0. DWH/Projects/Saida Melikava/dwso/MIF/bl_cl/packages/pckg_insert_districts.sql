﻿------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert customers data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_districts
AS
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_districts;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_districts
AS
/********wrk->cls*************/
/*****************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(1050);
  sql_stmt_select VARCHAR2(1050);
BEGIN
  sql_stmt_select:= q'< 
select DISTINCT  
CASE    
WHEN (INSTR(district_name,'-', 1, 1)>0 )    
THEN SUBSTR(district_name,1,3)      
||SUBSTR(district_name,(INSTR(district_name,'-', 1, 1)+1),3)    
WHEN LENGTH(district_name)>13    
THEN SUBSTR(district_name,1,3)      
||SUBSTR(district_name,7,3)    
WHEN district_name='Сибирский'    
THEN 'Сиб'    
WHEN district_name='Приволжский'    
THEN 'Привлж'    
WHEN district_name='Уральский'    
THEN 'Урал'    
ELSE SUBSTR(district_name,1,3)  
END AS code,  
district_name
FROM wrk_geodata   
>';
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls|| sql_stmt_select;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
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
  MERGE INTO bl_3NF.ce_districts ce USING
  ( SELECT district_code, district_desc FROM cls_districts
  MINUS
  SELECT district_code, district_desc FROM bl_3NF.ce_districts
  ) cls ON ( cls.district_code = ce.district_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.district_desc = cls.district_desc,
      ce.update_dt= sysdate 
WHEN NOT MATCHED THEN
  INSERT
    (
      district_id ,
      district_code ,
      district_desc
    )
    VALUES
    (
      seq_distr_3NF.nextval ,
      cls.district_code ,
      cls.district_desc
    ) ;
  COMMIT;
END;
END pckg_insert_districts;
/