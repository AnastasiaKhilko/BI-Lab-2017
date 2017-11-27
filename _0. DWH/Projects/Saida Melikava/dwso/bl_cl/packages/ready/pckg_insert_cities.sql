------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 24/11/2017
-- Purpose : Insert customers data from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_cities
AS
  PROCEDURE drop_seq(
      Object_Name IN VARCHAR2);
  PROCEDURE insert_bl_cls(
      source_table_wrk IN VARCHAR2,
      target_table_cls IN VARCHAR2);
  PROCEDURE insert_bl_3NF;
END pckg_insert_cities;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_cities
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
BEGIN
  sql_stmt_select:= q'< 
(SELECT DISTINCT geo_id||'CT' as geo_id, city_name,region_id
FROM wrk_geodata wrk
inner join cls_regions cls
on wrk.region_name=cls.region_desc
inner join bl_3nf.ce_regions ce
on cls.region_code=ce.region_code) 
>';
  sql_stmt_trunc :='TRUNCATE TABLE '|| target_table_cls;
  sql_stmt_insert:='INSERT INTO '|| target_table_cls|| ' SELECT SEQ_cit.NEXTVAL, geo_id, city_name,region_id FROM '|| sql_stmt_select;
  EXECUTE immediate sql_stmt_trunc;
  dbms_output.put_line('Table '|| target_table_cls||' is successfully truncated.');
  drop_seq('seq_cit');
  EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_cit INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE';
  dbms_output.put_line('New sequence is created.');
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
CREATE SEQUENCE seq_cit INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP SEQUENCE seq_cit_3nf;
CREATE SEQUENCE seq_cit_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  EXECUTE pckg_insert_cities.insert_bl_cls(source_table_wrk=>'wrk_geodata', target_table_cls=>'cls_cities');
  SELECT * FROM cls_cities ORDER BY city_src_id;
  EXECUTE pckg_insert_cities.insert_bl_3nf;
  SELECT * FROM bl_3nf.ce_cities ORDER BY city_id;
