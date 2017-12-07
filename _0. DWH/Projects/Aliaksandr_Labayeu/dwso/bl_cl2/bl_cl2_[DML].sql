-- cls_consumers
TRUNCATE TABLE cls_consumers;
INSERT INTO cls_consumers ( 
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

-- cls_departments
TRUNCATE TABLE cls_DEPARTMENTS;
INSERT INTO cls_DEPARTMENTS (
  DEPARTMENT_ID,
  DEPARTMENT_DESC,
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
  START_DT,
  END_DT,
  IS_ACTIVE,
  UPDATE_DT,
  INSERT_DT)
SELECT 
  department_id,
  department_desc,
  ced.address_id,
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
  start_dt,
  end_dt,
  is_active,
  sysdate,
  sysdate
FROM ce_departments ced
  LEFT JOIN ce_addresses cea ON cea.address_id = ced.address_id
  LEFT JOIN ce_cities cect ON cect.city_id = cea.city_id
  LEFT JOIN ce_countries cecn ON cecn.country_id = cect.country_id
  LEFT JOIN ce_subregions cesr ON cesr.subregion_id = cecn.subregion_id
  LEFT JOIN ce_regions cerg ON cerg.region_id = cesr.region_id ;
 
  
-- cls_products
TRUNCATE TABLE cls_PRODUCTS;
INSERT INTO cls_PRODUCTS (
  PRODUCT_ID,
  PRODUCT_DESC,
  PRODUCT_PRICE,
  CATEGORY_ID,
  CATEGORY_DESC,
  SUBCATEGORY_ID,
  SUBCATEGORY_DESC,
  SUBCATEGORY_SIZE,
  SUBCATEGORY_TOBACCO,
  LOCALIZATION_ID,
  LOCALIZATION_DESC,
  UPDATE_DT,
  INSERT_DT)
SELECT 
  product_id,
  product_name,
  price,
  cep.category_id,
  category_name,
  cepsc.subcategory_id,
  subcategory_name,
  "SIZE",
  tobacco,
  cel.localization_id,
  localization_name,
  sysdate,
  sysdate
FROM ce_products cep
  LEFT JOIN ce_product_category cepc ON cepc.category_id = cep.category_id
  LEFT JOIN ce_product_subcategory cepsc ON cepsc.category_id = cepc.category_id
  LEFT JOIN ce_localization cel ON cel.localization_id = cep.localization_id;

-- cls_products
TRUNCATE TABLE cls_PROMOTIONS;
INSERT INTO cls_PROMOTIONS (
  PROMO_ID,
  PROMO_NAME,
  PROMO_DESC,
  PROMO_COST,
  START_DT,
  END_DT,
  IS_ACTIVE,
  UPDATE_DT,
  INSERT_DT)
SELECT 
  promo_id,
  promo_name,
  promo_desc,
  promo_cost,
  start_dt,
  end_dt,
  is_active,
  sysdate,
  sysdate
FROM ce_promotions;

--cls_date
TRUNCATE TABLE cls_date;
INSERT INTO cls_date
-- DROP TABLE dim_date1;
-- CREATE TABLE dim_date1 AS 
SELECT
TRUNC(TO_DATE('31/12/1979','DD/MM/YYYY')) + n AS Full_Date,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n,'d')) AS Day_Week,
UPPER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'Dy')) AS Day_Short,
TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'DAY') AS Day_Long,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'DD')) AS Day_Month,
LAST_DAY(TO_DATE('31/12/1979','DD/MM/YYYY') + n) AS LastDay_Month,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'DDD')) AS Day_Year,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'MM')) AS Month_Year,
UPPER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'Mon')) AS Month_Short,
UPPER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'Month')) AS Month_Long,
TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'YYYY') || '-' || TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM') AS Month_Desc,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n, 'Q')) AS Quarter,
  CASE
    WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1979','DD/MM/YYYY') + n)) <=6 THEN '1'
    ELSE '2'
  END
AS Year_Half,
TO_NUMBER(TO_CHAR(TO_DATE('31/12/1979','DD/MM/YYYY') + n,'YYYY')) AS Year
FROM (
select level n
from dual
connect by level <= 18500 ORDER BY 1 DESC
);

-- cls_sales
TRUNCATE TABLE cls_sales;
INSERT INTO cls_sales (
  PRODUCT_ID,
  DEPARTMENT_ID,
  CONSUMER_ID,
  PROMO_ID,
  DATE_ID,
  COST,
  AMOUNT,
  UPDATE_DT,
  INSERT_DT
  )
SELECT 
  product_id,
  department_id,
  consumer_id,
  promo_id,
  TRUNC(sale_date),
  price*amount AS cost,
  amount,
  sysdate,
  sysdate
FROM ce_sales
  LEFT JOIN ce_products USING (product_id);