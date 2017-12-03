CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_customers;
  PROCEDURE merge_table_customers;
						
END pkg_etl_insert_customers;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
---------------------------------------------------  
PROCEDURE insert_table_customers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls2_customer');
  BEGIN
    INSERT
INTO CLS2_customer
  (
    "CUST_ID" ,
	"LAST_NAME" ,
	"FIRST_NAME" , 
	"MIDDLE_NAME" , 
	"AGE" , 
	"GENDER" , 
	"EMAIL" , 
	"PHONE" , 
	"ADDRESS" , 
	"CITY" , 
	"ATE" ,
  "COUNTRY",
	"START_DT" , 
	"END_DT" 
  )
SELECT --+PARALLEL(3)
src.сustomer_srcid AS cust_id,
  src.last_name,
  src.first_name,
  src.middle_name,
  src.age,
    src.email,
  src.phone ,
  ca.address,
  cc.city,
  cat.ate_name,
  cco.country_name,
  src.start_dt,
  src.end_dt
FROM bl_3nf.ce_CUSTOMER src
LEFT JOIN BL_3NF.ce_address ca
ON src.ADDRESS_SRCID=ca.address_srcid,
LEFT JOIN bl_3nf.ce_city cc
ON ca.city_srcid=cc.city_srcid,
LEFT JOIN bl_3nf.ce_ate cat
ON cc.ate_srcid=cat.ate_srcid,
LEFT JOIN BL_3NF.CE_COUNTRY cco
ON cat.country_srcid=cco.country_srcid;
  END;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  END insert_table_customers;
--------------------------------------------------- 
PROCEDURE merge_table_customers
IS
BEGIN
MERGE INTO bl_dm.dim_customer tgt USING
(SELECT "CUST_ID" ,
	"LAST_NAME" ,
	"FIRST_NAME" , 
	"MIDDLE_NAME" , 
	"AGE" , 
	"GENDER" , 
	"EMAIL" , 
	"PHONE" , 
	"ADDRESS" , 
	"CITY" , 
	"ATE" ,
  "COUNTRY",
	"START_DT" , 
	"END_DT" 
FROM cls_suppler_scd
MINUS
SELECT "CUST_ID" ,
	"LAST_NAME" ,
	"FIRST_NAME" , 
	"MIDDLE_NAME" , 
	"AGE" , 
	"GENDER" , 
	"EMAIL" , 
	"PHONE" , 
	"ADDRESS" , 
	"CITY" , 
	"ATE" ,
  "COUNTRY",
	"START_DT" , 
	"END_DT" 
FROM bl_dm.dim_customer
) src ON ( tgt.last_name = src.last_name AND tgt.first_name = src.first_name AND tgt.middle_name = src.middle_name
and tgt.email = src.email and tgt.age=src.age and tgt.gender=src.gender
AND  tgt.phone = src.phone AND tgt.address = src.address AND tgt.city = src.city 
AND tgt.country = src.country AND tgt.ate = src.ate AND tgt.start_dt = src.start_dt)
WHEN matched THEN
  UPDATE
  SET tgt.cust_id = src.cust_id,
    tgt.end_dt        = src.end_dt
    WHEN NOT matched THEN
  INSERT
    (
      "CUST_ID" ,
	"LAST_NAME" ,
	"FIRST_NAME" , 
	"MIDDLE_NAME" , 
	"AGE" , 
	"GENDER" , 
	"EMAIL" , 
	"PHONE" , 
	"ADDRESS" , 
	"CITY" , 
	"ATE" ,
  "COUNTRY",
	"START_DT" , 
	"END_DT" 
    )
    VALUES
    (
      bl_dm.dim_cust_seq.NEXTVAL,
      src."LAST_NAME" ,
	src."FIRST_NAME" , 
	src."MIDDLE_NAME" , 
	src."AGE" , 
	src."GENDER" , 
	src."EMAIL" , 
	src."PHONE" , 
	src."ADDRESS" , 
	src."CITY" , 
	src."ATE" ,
  src."COUNTRY",
	src."START_DT" , 
	src."END_DT" 
    ) ;
   COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END merge_table_customers;
--------------------------------------------------- 
END pkg_etl_insert_customers;