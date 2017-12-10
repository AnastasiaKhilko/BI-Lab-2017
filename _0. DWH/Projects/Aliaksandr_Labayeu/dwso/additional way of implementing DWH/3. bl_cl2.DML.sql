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

---------------------------------------------------------------------------------------------
-- DATA WAREHOUSE LAYER ---------------------------------------------------------------------
---------------------------------------------------------------------------------------------

-- dim_Consumers 
MERGE INTO dim_consumers dim
USING ( SELECT * FROM cls_consumers 
        MINUS
        SELECT CONSUMER_ID, CONSUMER_DESC, RATE_ID, RATE_DESC, RESPONSIBLE_ID, RESPONSIBLE_DESC, ADDRESS_ID, ADDRESS_DESC, CITY_ID, CITY_DESC, COUNTRY_ID, COUNTRY_DESC, SUBREGION_ID, SUBREGION_DESC, REGION_ID, REGION_DESC, POSTAL_CODE, PHONE,UPDATE_DT,INSERT_DT
        FROM dim_consumers) cl
  ON (cl.consumer_id = dim.consumer_id AND
      cl.RESPONSIBLE_ID = dim.RESPONSIBLE_ID AND
      cl.RATE_ID =  dim.RATE_ID AND
      cl.ADDRESS_ID = dim.ADDRESS_ID
       )
WHEN MATCHED
  THEN UPDATE
    SET
      dim.CONSUMER_DESC = cl.CONSUMER_DESC,
      dim.RATE_DESC = cl.RATE_DESC,
      dim.RESPONSIBLE_DESC = cl.RESPONSIBLE_DESC,
      dim.ADDRESS_DESC = cl.ADDRESS_DESC,
      dim.CITY_ID =  cl.CITY_ID,
      dim.CITY_DESC = cl.CITY_DESC,
      dim.COUNTRY_ID = cl.COUNTRY_ID,
      dim.COUNTRY_DESC = cl.COUNTRY_DESC,
      dim.SUBREGION_ID = cl.SUBREGION_ID,
      dim.SUBREGION_DESC = cl.SUBREGION_DESC,
      dim.REGION_ID = cl.REGION_ID,
      dim.REGION_DESC = cl.REGION_DESC,
      dim.POSTAL_CODE = cl.POSTAL_CODE,
      dim.PHONE = cl.PHONE,
      dim.UPDATE_DT = sysdate
WHEN NOT MATCHED 
  THEN INSERT
    VALUES (
      seq_dconsumers.nextval,
      cl.CONSUMER_ID,
      cl.CONSUMER_DESC,
      cl.RATE_ID,
      cl.RATE_DESC,
      cl.RESPONSIBLE_ID,
      cl.RESPONSIBLE_DESC,
      cl.ADDRESS_ID,
      cl.ADDRESS_DESC,
      cl.CITY_ID,
      cl.CITY_DESC,
      cl.COUNTRY_ID,
      cl.COUNTRY_DESC,
      cl.SUBREGION_ID,
      cl.SUBREGION_DESC,
      cl.REGION_ID,
      cl.REGION_DESC,
      cl.POSTAL_CODE,
      cl.PHONE,
      sysdate,
      sysdate);

-- dim_Departments 
MERGE INTO dim_departments dim 
USING( SELECT * FROM cls_departments ) cl
  ON (
    dim.department_id = cl.department_id AND
    dim.address_id = cl.address_id )
  WHEN MATCHED 
    THEN UPDATE
      SET 
          dim.DEPARTMENT_DESC = cl.DEPARTMENT_DESC,
          dim.ADDRESS_DESC    = cl.ADDRESS_DESC,
          dim.CITY_ID         = cl.CITY_ID,
          dim.CITY_DESC       = cl.CITY_DESC,
          dim.COUNTRY_ID      = cl.COUNTRY_ID,
          dim.COUNTRY_DESC    = cl.COUNTRY_DESC,
          dim.SUBREGION_ID    = cl.SUBREGION_ID,
          dim.SUBREGION_DESC  = cl.SUBREGION_DESC,
          dim.REGION_ID       = cl.REGION_ID,
          dim.REGION_DESC     = cl.REGION_DESC,
          dim.PHONE           = cl.PHONE,
          dim.POSTAL_CODE     = cl.POSTAL_CODE,
          dim.START_DT        = cl.START_DT,
          dim.END_DT          = cl.END_DT,
          dim.IS_ACTIVE       = cl.is_active,
          dim.UPDATE_DT       = sysdate
  WHEN NOT MATCHED
    THEN INSERT VALUES (
      seq_ddepartments.nextval,
      cl.DEPARTMENT_ID,
      cl.DEPARTMENT_DESC,
      cl.ADDRESS_ID,
      cl.ADDRESS_DESC,
      cl.CITY_ID,
      cl.CITY_DESC,
      cl.COUNTRY_ID,
      cl.COUNTRY_DESC,
      cl.SUBREGION_ID,
      cl.SUBREGION_DESC,
      cl.REGION_ID,
      cl.REGION_DESC,
      cl.PHONE,
      cl.POSTAL_CODE,
      cl.START_DT,
      cl.END_DT,
      cl.IS_ACTIVE,
      sysdate,
      sysdate);
 
-- SELECT COUNT (*) FROM dim_departments;
-- SELECT * FROM dim_departments;

-- dim_Products

-- SELECT * FROM  cls_products;
-- SELECT * FROM  dim_products;
MERGE INTO dim_products dim
USING (SELECT * FROM cls_products) cl
  ON (cl.product_id = dim.product_id AND
      cl.category_id = dim.category_id AND
      cl.localization_id = dim.localization_id)
    WHEN MATCHED 
      THEN UPDATE
        SET
          dim.PRODUCT_DESC = PRODUCT_DESC,
          dim.PRODUCT_PRICE = PRODUCT_PRICE,
          dim.CATEGORY_DESC = CATEGORY_DESC,
          dim.SUBCATEGORY_ID = SUBCATEGORY_ID,
          dim.SUBCATEGORY_DESC = SUBCATEGORY_DESC,
          dim.SUBCATEGORY_SIZE = SUBCATEGORY_SIZE,
          dim.SUBCATEGORY_TOBACCO = SUBCATEGORY_TOBACCO,
          dim.LOCALIZATION_DESC = LOCALIZATION_DESC,
          UPDATE_DT = sysdate
    WHEN NOT MATCHED
      THEN INSERT
        VALUES (
          seq_dproduct.nextval,
          cl.PRODUCT_ID,
          cl.PRODUCT_DESC,
          cl.PRODUCT_PRICE,
          cl.CATEGORY_ID,
          cl.CATEGORY_DESC,
          cl.SUBCATEGORY_ID,
          cl.SUBCATEGORY_DESC,
          cl.SUBCATEGORY_SIZE,
          cl.SUBCATEGORY_TOBACCO,
          cl.LOCALIZATION_ID,
          cl.LOCALIZATION_DESC,
          sysdate,
          sysdate);

-- dim_PROMOTIONS
MERGE INTO dim_promotions dim
USING (SELECT * FROM cls_promotions) cl
  ON (
    dim.PROMO_id = cl.promo_id
    )
  WHEN MATCHED
    THEN UPDATE
      SET
        dim.PROMO_NAME = cl.PROMO_NAME,
        dim.PROMO_DESC = dim.PROMO_DESC,
        dim.PROMO_COST = dim.PROMO_COST,
        dim.START_DT = dim.START_DT,
        dim.END_DT = dim.END_DT,
        dim.IS_ACTIVE = dim.IS_ACTIVE,
        dim.UPDATE_DT = sysdate
  WHEN NOT MATCHED
    THEN INSERT 
      VALUES (
          seq_dpromotion.nextval,
          cl.PROMO_ID,
          cl.PROMO_NAME,
          cl.PROMO_DESC,
          cl.PROMO_COST,
          cl.START_DT,
          cl.END_DT,
          cl.IS_ACTIVE,
          sysdate,
          sysdate
        );

-- dim_DATE
MERGE INTO dim_date dim
  USING (SELECT * FROM cls_date) cl 
  ON ( TRUNC(dim.date_id) = TRUNC(cl.date_id))
    WHEN MATCHED
      THEN UPDATE 
        SET 
          dim.DAY_WEEK	=	cl.DAY_WEEK		,
          dim.DAY_SHORT	=	cl.DAY_SHORT		,
          dim.DAY_LONG	=	cl.DAY_LONG		,
          dim.DAY_MONTH	=	cl.DAY_MONTH		,
          dim.LASTDAY_MONTH	=	cl.LASTDAY_MONTH		,
          dim.DAY_YEAR	=	cl.DAY_YEAR		,
          dim.MONTH_YEAR	=	cl.MONTH_YEAR		,
          dim.MONTH_SHORT	=	cl.MONTH_SHORT		,
          dim.MONTH_LONG	=	cl.MONTH_LONG		,
          dim.MONTH_DESC	=	cl.MONTH_DESC		,
          dim.QUARTER	=	cl.QUARTER		,
          dim.YEAR_HALF	=	cl.YEAR_HALF		,
          dim.YEAR	=	cl.YEAR		
    WHEN NOT MATCHED
      THEN INSERT 
        VALUES (
          (cl.DATE_ID),
          cl.DAY_WEEK	,
          cl.DAY_SHORT	,
          cl.DAY_LONG	,
          cl.DAY_MONTH	,
          cl.LASTDAY_MONTH	,
          cl.DAY_YEAR	,
          cl.MONTH_YEAR	,
          cl.MONTH_SHORT	,
          cl.MONTH_LONG	,
          cl.MONTH_DESC	,
          cl.QUARTER	,
          cl.YEAR_HALF	,
          cl.YEAR	
        );

-- FCT_SALES
MERGE INTO FCT_SALES fct
USING (SELECT * FROM CLS_SALES) cl
  ON (
    fct.PRODUCT_ID = cl.PRODUCT_ID AND 
    fct.DEPARTMENT_ID = cl.DEPARTMENT_ID AND
    fct.CONSUMER_ID = cl.CONSUMER_ID AND
    fct.PROMO_ID = cl.PROMO_ID AND
    TRUNC(fct.DATE_ID) = TRUNC(cl.DATE_ID)
    )
  WHEN MATCHED
    THEN UPDATE
      SET 
        fct.COST = cl.COST, 
        fct.AMOUNT = cl.AMOUNT,
        fct.UPDATE_DT = sysdate
  WHEN NOT MATCHED
    THEN INSERT
      VALUES (
        cl.PRODUCT_ID,
        cl.DEPARTMENT_ID,
        cl.CONSUMER_ID,
        cl.PROMO_ID,
        TRUNC(cl.DATE_ID),
        cl.COST,
        cl.AMOUNT,
        sysdate,
        sysdate);

COMMIT;