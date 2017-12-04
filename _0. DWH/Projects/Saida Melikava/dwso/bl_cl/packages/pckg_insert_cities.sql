------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert customers data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_cities
AS
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_cities;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_cities
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
 SELECT DISTINCT geo_id||substr(city_name,1,2)||'CT' as geo_id, city_name,region_id
FROM wrk_geodata wrk
inner join cls_regions cls
on wrk.region_name=cls.region_desc
inner join bl_3nf.ce_regions ce
on cls.region_code=ce.region_code 
>';
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls||sql_stmt_select;
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
  MERGE INTO bl_3nf.ce_cities ce USING
  ( SELECT city_code, city_desc, region_id FROM cls_cities
    MINUS
    SELECT city_code, city_desc, region_id FROM bl_3nf.ce_cities
  ) cls ON ( cls.city_code = ce.city_code )
WHEN MATCHED THEN
  UPDATE
  SET ce.city_desc = cls.city_desc,
    ce.update_dt   =sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      city_id ,
      city_code ,
      city_desc,
      region_id
    )
    VALUES
    (
      seq_cit_3nf.nextval ,
      cls.city_code ,
      cls.city_desc,
      cls.region_id
    ) ;
COMMIT;
END;
END pckg_insert_cities;
/

 
