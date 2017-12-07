-- Every exection is made on the basis of PMI DWH 
-- USER bl_cl
ALTER SESSION ENABLE PARALLEL DML;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
-- SELECT
-- Simple execution
EXPLAIN PLAN FOR
SELECT * FROM FCT_sales;
-- Parallel execution
EXPLAIN PLAN FOR 
SELECT /*+ PARALLEL(4) */ * FROM FCT_Sales;

SELECT plan_id, operation, optimizer, options, cpu_cost, io_cost, cost FROM PLAN_TABLE ORDER BY timestamp DESC;

-- DDL
-- USER bl_cl
CREATE TABLE wrk_PROMOTIONS AS 
          SELECT
            ROUND (dbms_random.value (1,99), 0 ) || dbms_random.string('b',2) || ROUND (dbms_random.value (1,99), 0 ) AS PROMO_CODE,
            'Promotion ' || dbms_random.string('b',4) || ROUND(dbms_random.value(4, 99)) AS PROMO_NAME,
            PROMO_NAME AS PROMO_DESC,
            PROMO_COST AS PROMO_COST
          FROM SH.PROMOTIONS;
          
-- DML
-- cls_consumers 
-- USER bl_cl2
TRUNCATE TABLE cls_consumers;

INSERT 
INTO cls_consumers ( 
  CONSUMER_ID, 
  CONSUMER_DESC, 
  RATE_ID, 
  RATE_DESC, 
  RESPONSIBLE_ID, 
  RESPONSIBLE_DESC, 
  ADDRESS_ID, 
  ADDRESS_DESC, 
  CITY_ID, 
  CITY_DESC,
  COUNTRY_ID,
  COUNTRY_DESC, 
  SUBREGION_ID, 
  SUBREGION_DESC, 
  REGION_ID, 
  REGION_DESC, 
  POSTAL_CODE, 
  PHONE,
  UPDATE_DT,
  INSERT_DT)
SELECT
  CONSUMER_ID, 
  CONSUMER_TITLE, 
  cec.CONSUMER_RATE_ID,
  rate_title,
  cec.RESP_ID,
  FIRST_NAME || LAST_NAME AS responsible_desc,
  cec.address_id,
  address,
  cea.city_id,
  city_name,
  cect.country_id,
  country_name,
  cesr.subregion_id,
  subregion_name,
  cesr.region_id,
  region_name,
  cea.postal_code,
  cea.phone,
  sysdate,
  sysdate
FROM ce_consumers cec
  LEFT JOIN ce_consumer_rate cecr ON cecr.consumer_Rate_id = cec.consumer_Rate_id
  LEFT JOIN ce_responsible cer ON cer.resp_id = cec.resp_id
  LEFT JOIN ce_addresses cea ON cea.address_id = cec.address_id
  LEFT JOIN ce_cities cect ON cect.city_id = cea.city_id
  LEFT JOIN ce_countries cecn ON cecn.country_id = cect.country_id
  LEFT JOIN ce_subregions cesr ON cesr.subregion_id = cecn.subregion_id
  LEFT JOIN ce_regions cerg ON cerg.region_id = cesr.region_id
;

commit;