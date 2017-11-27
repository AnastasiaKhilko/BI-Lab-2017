------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert customers data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_regions
AS
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_regions;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_regions
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
/********wrk->cls*************/
/*****************************/
PROCEDURE insert_bl_cls(
    source_table_wrk IN VARCHAR2,
    target_table_cls IN VARCHAR2)
IS
  sql_stmt_trunc  VARCHAR2(250);
  sql_stmt_insert VARCHAR2(1050);
  sql_stmt_select VARCHAR2(1050);
  ex_seq          EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_seq, -02289 );
BEGIN
  sql_stmt_select:= q'< 
(SELECT DISTINCT  
CASE    
WHEN (INSTR(region_name,' ', 1, 1)>0 )    
THEN SUBSTR(region_name,1,4)      
||SUBSTR(region_name,(INSTR(region_name,' ', 1, 1)+1),2)    
WHEN (INSTR(region_name,'-', 1, 1)>0 )    
THEN SUBSTR(region_name,1,3)      
||SUBSTR(region_name,(INSTR(region_name,'-', 1, 1)+1),3)    
ELSE SUBSTR(region_name,1,3)  
END AS region,  
region_name,
district_id
FROM wrk_geodata wrk
inner join cls_districts cls
on wrk.district_name=cls.district_desc
inner join bl_3nf.ce_districts ce
on cls.district_code=ce.district_code)
>';
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||' SELECT SEQ_REG.NEXTVAL, REGION,REGION_NAME, DISTRICT_ID FROM '|| sql_stmt_select;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  drop_seq('seq_reg');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_reg INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
  dbms_output.put_line(sql_stmt_insert);
  EXECUTE immediate sql_stmt_insert;
  dbms_output.put_line('Data in the table '||target_table_cls||' is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
  dbms_output.put_line('Transaction is commited.');
EXCEPTION
WHEN ex_seq THEN
  dbms_output.put_line( 'does not exist');
WHEN OTHERS THEN
  RAISE;
END insert_bl_cls;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
MERGE INTO bl_3nf.ce_regions ce USING
( SELECT region_code, region_desc, district_id FROM cls_regions
MINUS
SELECT region_code, region_desc,district_id FROM bl_3nf.ce_regions
) cls ON ( cls.region_code = ce.region_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.region_desc = cls.region_desc,
      ce.update_dt       =sysdate
    WHEN NOT MATCHED THEN
  INSERT
    (
      region_id ,
      region_code ,
      region_desc,
      district_id
    )
    VALUES
    (
      seq_reg_3nf.nextval ,
      cls.region_code ,
      cls.region_desc,
      cls.district_id
    ) ;
COMMIT;
END;
END pckg_insert_regions;
/
EXECUTE pckg_insert_regions.insert_bl_cls(source_table_wrk=>'wrk_geodata', target_table_cls=>'cls_regions');
SELECT * FROM cls_regions
order by region_desc;
EXECUTE pckg_insert_regions.insert_bl_3NF;
select * from bl_3nf.ce_regions;