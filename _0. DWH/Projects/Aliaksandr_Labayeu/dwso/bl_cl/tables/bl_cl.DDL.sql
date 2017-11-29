-- DROPPING synonyms
execute pkg_drop.DROP_Proc ('EXT_GEO_countries','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_STRUCTURE','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_cntr2structure','synonym');
execute pkg_drop.DROP_Proc ('EXT_PRODUCTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_CONSUMERS','synonym');
execute pkg_drop.DROP_Proc ('EXT_DEPARTMENTS','synonym');

-- DROPPING tables
---- wrk
execute pkg_drop.DROP_Proc('wrk_geo_countries','table');
execute pkg_drop.DROP_Proc('wrk_geo_structure','table');
execute pkg_drop.DROP_Proc('wrk_geo_cntr2structure','table');
execute pkg_drop.DROP_Proc('wrk_products','table');
execute pkg_drop.DROP_Proc('wrk_consumers','table');
execute pkg_drop.DROP_Proc('wrk_departments','table');
execute pkg_drop.DROP_Proc('wrk_promotions','table');
execute pkg_drop.DROP_Proc('wrk_sales','table');
---- cls
execute pkg_drop.DROP_Proc('cls_geo_countries','table');
execute pkg_drop.DROP_Proc('cls_geo_structure','table');
execute pkg_drop.DROP_Proc('cls_geo_cntr2structure','table');
execute pkg_drop.DROP_Proc('cls_products','table');
execute pkg_drop.DROP_Proc('cls_consumers','table');
execute pkg_drop.DROP_Proc('cls_departments','table');
execute pkg_drop.DROP_Proc('cls_promotions','table');
execute pkg_drop.DROP_Proc('cls_sales','table');
---- 3nf
execute pkg_drop.DROP_Proc('bl_3nf.ADDRESSES','table');
execute pkg_drop.DROP_Proc('bl_3nf.CITIES','table');
execute pkg_drop.DROP_Proc('bl_3nf.CONSUMER_RATE','table');
execute pkg_drop.DROP_Proc('bl_3nf.CONSUMERS','table');
execute pkg_drop.DROP_Proc('bl_3nf.COUNTRIES','table');
execute pkg_drop.DROP_Proc('bl_3nf.DEPARTMENTS','table');
execute pkg_drop.DROP_Proc('bl_3nf.LOCALIZATION','table');
execute pkg_drop.DROP_Proc('bl_3nf.PACKAGE','table');
execute pkg_drop.DROP_Proc('bl_3nf.PAY_STATE','table');
execute pkg_drop.DROP_Proc('bl_3nf.PAYMENTS','table');
execute pkg_drop.DROP_Proc('bl_3nf.PRODUCT_CATEGORY','table');
execute pkg_drop.DROP_Proc('bl_3nf.PRODUCT_SUBCATEGORY','table');
execute pkg_drop.DROP_Proc('bl_3nf.PRODUCTS','table');
execute pkg_drop.DROP_Proc('bl_3nf.PROMOTIONS','table');
execute pkg_drop.DROP_Proc('bl_3nf.REGIONS','table');
execute pkg_drop.DROP_Proc('bl_3nf.RESPONSIBLE','table');
execute pkg_drop.DROP_Proc('bl_3nf.SALES','table');
execute pkg_drop.DROP_Proc('bl_3nf.RESPONSIBLE','table');
execute pkg_drop.DROP_Proc('bl_3nf.RESPONSIBLE','table');

CREATE OR REPLACE SYNONYM EXT_GEO_countries FOR sa_src.ext_geo_countries_iso3166;
CREATE OR REPLACE SYNONYM EXT_GEO_STRUCTURE FOR sa_src.ext_geo_structure_iso3166;
CREATE OR REPLACE SYNONYM EXT_GEO_cntr2structure FOR sa_src.ext_cntr2structure_iso3166;
CREATE OR REPLACE SYNONYM EXT_PRODUCTS FOR sa_src.ext_products;
CREATE OR REPLACE SYNONYM EXT_CONSUMERS FOR sa_src.ext_consumers;
CREATE OR REPLACE SYNONYM EXT_DEPARTMENTS FOR sa_src.ext_departments;
CREATE OR REPLACE SYNONYM EXT_LOCATIONS FOR sa_src.ext_locations;

--==========================================================================================
-- Creating Tables
-- Working tables
  /*
  execute pkg_drop.DROP_proc('seq_promotions','sequence');
  CREATE SEQUENCE seq_promotions
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;

  execute pkg_drop.DROP_proc('seq_sales','sequence');
  CREATE SEQUENCE seq_sales
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;    
  
  execute pkg_drop.DROP_proc('seq_payments','sequence');
  CREATE SEQUENCE seq_payments
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;     
 */
 
CREATE TABLE wrk_geo_countries AS SELECT * FROM EXT_GEO_countries;
CREATE TABLE wrk_geo_structure AS SELECT * FROM EXT_GEO_STRUCTURE;
CREATE TABLE wrk_geo_cntr2structure AS SELECT * FROM EXT_GEO_cntr2structure;
---
CREATE TABLE wrk_products AS SELECT * FROM EXT_PRODUCTS;
CREATE TABLE wrk_consumers AS SELECT * FROM EXT_CONSUMERS;
CREATE TABLE wrk_departments AS SELECT * FROM EXT_DEPARTMENTS;
CREATE TABLE wrk_locations AS SELECT * FROM EXT_LOCATIONS;
CREATE TABLE wrk_PROMOTIONS AS 
          SELECT
            PROMO_ID AS PROMO_ID,
            ROUND (dbms_random.value (1,99), 0 ) || dbms_random.string('b',2) || ROUND (dbms_random.value (1,99), 0 ) AS PROMO_CODE,
            'Promotion ' || dbms_random.string('b',4) || ROUND(dbms_random.value(4, 99)) AS PROMO_NAME,
            PROMO_NAME AS PROMO_DESC,
            PROMO_COST AS PROMO_COST,
            TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS START_DT,
            TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS END_DT,
            ROUND(dbms_random.value (1,2),0) AS IS_ACTIVE
          FROM SH.PROMOTIONS;

-------------     WHAT SHALL I DO?!??!?!?!??!?!?  
CREATE TABLE wrk_SALES AS
          SELECT
            seq_sales.nextval AS SALE_ID,
            TO_DATE(TRUNC(DBMS_RANDOM.VALUE(2454467,2462503)),'J') AS DATE_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(dep_id) FROM wrk_DEPARTMENTS)),0) AS DEPARTMENT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(cons_id) FROM wrk_CONSUMERS)),0) AS CONSUMER_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(product_id) FROM wrk_PRODUCTS)), 0) AS PRODUCT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(promo_id) FROM wrk_PROMOTIONS)),0) AS PROMO_ID,
            ROUND(dbms_random.value(1,2)) AS PAY_STATE_ID
          FROM dual
          CONNECT BY level <=5000;
          
CREATE TABLE wrk_PAYMENTS AS 
          SELECT 
            seq_payments.nextval AS PAYMENT_ID,
            ROUND(dbms_random.value(1,900)) || UPPER(dbms_random.string('a',4)) || ROUND(dbms_random.value(1,44)) AS PAYMENT_CODE,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(cons_id) FROM wrk_consumers)),0) AS CONSUMER_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(sale_id) FROM wrk_sales)),0) AS SALE_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(dep_id) FROM wrk_departments)),0) AS DEPARTMENT_ID,
            ROUND((dbms_random.value ( 0.51, 50.49 ))*(SELECT PROD_PRICE FROM wrk_PRODUCTS WHERE rownum <=1),0) AS COST,
            ROUND(dbms_random.value ( 0.51, 50.49 ),0) AS AMOUNT
          FROM dual
          CONNECT BY level <=9000;

--==========================================================================================
-- CLS TABLES
--==========================================================================================

-- CLS_PRODUCT_CATEGORY
execute pkg_drop.DROP_proc('cls_PRODUCT_CATEGORY','table');   
CREATE TABLE CLS_PRODUCT_CATEGORY
(
  "CATEGORY_CODE" VARCHAR2(50),
  "CATEGORY_NAME" VARCHAR2(50),
  "UPDATE_DT" DATE,
  "INSERT_DT" DATE
)
;

-- CLS_PRODUCT_SUBCATEGORY
execute pkg_drop.DROP_proc('CLS_PRODUCT_SUBCATEGORY','table');           
CREATE TABLE CLS_PRODUCT_SUBCATEGORY
(
	"SUBCATEGORY_CODE" VARCHAR2(50),
	"SUBCATEGORY_NAME" VARCHAR2(50),
	"CATEGORY_CODE" VARCHAR(10),
	"SIZE" NUMBER(3),
	"TOBACCO" NUMBER(3,1),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

-- CLS_LOCALIZATION [lookup]
execute pkg_drop.DROP_proc('CLS_LOCALIZATION','table');           
CREATE TABLE "CLS_LOCALIZATION"
(
	"LOCALIZATION_ID" NUMBER(8,2) NOT NULL,
	"LOCALIZATION_NAME" VARCHAR2(50)
)
;

execute pkg_drop.DROP_proc('seq_localization','sequence');
CREATE SEQUENCE seq_localization
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;

-- CLS_PRODUCTS
execute pkg_drop.DROP_proc('CLS_PRODUCTS','table');           
CREATE TABLE CLS_PRODUCTS
(
	"PRODUCT_CODE" VARCHAR2(20),
	"PRODUCT_NAME" VARCHAR2(50),
	"LOCALIZATION_CODE" VARCHAR2(20),
	"CATEGORY_CODE" VARCHAR2(20),
	"START_DT" DATE DEFAULT SYSDATE,
	"END_DT" DATE DEFAULT '31-DEC-9999',
	"IS_ACTIVE" VARCHAR2(1) DEFAULT 'Y',
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

-- CLS_OCCUPATION
execute pkg_drop.DROP_proc('CLS_OCCUPATION','table');           
CREATE TABLE CLS_OCCUPATION
(
	"OCCUPATION_CODE" VARCHAR2(20),
	"OCCUPATION_NAME" VARCHAR2(50),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

execute pkg_drop.DROP_proc('seq_occupation','sequence');
CREATE SEQUENCE seq_occupation
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;   

-- CLS_RESPONSIBLE
execute pkg_drop.DROP_proc('CLS_RESPONSIBLE','table');           
CREATE TABLE CLS_RESPONSIBLE
(
	"RESP_CODE" VARCHAR2(50),
	"FIRST_NAME" VARCHAR2(50),
	"LAST_NAME" VARCHAR2(50),
	"PHONE" VARCHAR2(50),
	"EMAIL" VARCHAR2(50),
	"BIRTHDAY" DATE,
	"AGE" NUMBER(3),
	"OCCUPATION_CODE" VARCHAR(20),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

-- CLS_CONSUMER_RATE
execute pkg_drop.DROP_proc('CLS_CONSUMER_RATE','table');
CREATE TABLE CLS_CONSUMER_RATE
(
	"CONSUMER_RATE_ID" NUMBER(8,2) NOT NULL,
	"RATE_TITLE" VARCHAR2(50)
)
;

-- CLS_REGIONS
execute pkg_drop.DROP_proc('CLS_REGIONS','table');
CREATE TABLE CLS_REGIONS (
  REGION_CODE VARCHAR2(3),
  REGION_NAME VARCHAR2(50)
  );

-- CLS_SUBREGIONS
execute pkg_drop.DROP_proc('CLS_SUBREGIONS','table');
CREATE TABLE CLS_SUBREGIONS (
  SUBREGION_CODE VARCHAR2(4),
  SUBREGION_NAME VARCHAR2(100),
  REGION_CODE VARCHAR(3)
  );

-- CLS_COUNTRIES
execute pkg_drop.DROP_proc('CLS_COUNTRIES','table');
CREATE TABLE CLS_COUNTRIES (
  country_code2 VARCHAR2(10),
  country_code3 VARCHAR2(10),
  country_name VARCHAR2(100),
  subregion_code VARCHAR(4)
  );

-- CLS_CITIES
execute pkg_drop.DROP_proc('CLS_CITIES','table');
CREATE TABLE CLS_CITIES (
  city_code VARCHAR2(10),
  city_name VARCHAR2(50),
  country_code VARCHAR2(50)
)
;

-- CLS_ADDRESSES
execute pkg_drop.DROP_proc('CLS_ADDRESSES','table');
CREATE TABLE CLS_ADDRESSES
(
	"ADDRESS_CODE" VARCHAR2(50),
	"ADDRESS" VARCHAR2(50),
	"POSTAL_CODE" VARCHAR2(50),
	"PHONE" VARCHAR2(50),
	"CITY_CODE" VARCHAR2(10),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;










-- CLS_CONSUMERS
execute pkg_drop.DROP_proc('CLS_CONSUMERS','table');
CREATE TABLE CLS_CONSUMERS
(
	"CONSUMER_CODE" NUMBER(8,2),
	"CONSUMER_TITLE" VARCHAR2(50),
	"CONSUMER_RATE_CODE" NUMBER(8,2),
	"ADDRESS_CODE" NUMBER(8,2),
	"RESP_CODE" VARCHAR2(10),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

/*--------------------
CREATE TABLE cls_PRODUCTS
(
	"PRODUCT_ID" NUMBER(8,2) NOT NULL,
	"PRODUCT_NAME" VARCHAR2(50),
	"SIZE" VARCHAR2(50),
	"TOBACCO" VARCHAR2(50),
	"LOCALIZATION_ID" NUMBER(8,2),
	"CATEGORY_ID" NUMBER(8,2),
	"PACKAGE_ID" NUMBER(8,2),
	"PRODUCT_CODE" NUMBER(8,2),
	"START_DT" DATE,
	"END_DT" DATE,
	"IS_ACTIVE" NUMBER(8,2)
)
;

CREATE TABLE cls_consumers
    (
     cons_id NUMBER(5),
     gender VARCHAR2(10),
      -- Field FullName was devided into 3 
       Title VARCHAR2(4), 
       First_Name VARCHAR2(50),
       Last_Name VARCHAR2(50),
     StreetAddress VARCHAR2(255),
     City	VARCHAR2(50),
     State VARCHAR2(50),
     StateFull VARCHAR(50),
     ZipCode VARCHAR(10),
     Country_CODE	VARCHAR2(2),
     Country	VARCHAR2(20),
     EmailAddress VARCHAR2(50),
     TelephoneNumber	VARCHAR2(50),
     TelephoneCountryCode	NUMBER(4),
     Birthday VARCHAR2(20),
     Age	NUMBER(3),
     CCType	VARCHAR2(20),
     CCExpires	VARCHAR2(20),
     WesternUnion	NUMBER(10),
     Color	VARCHAR2(10),
     Occupation	VARCHAR(20),
     Company	VARCHAR2(30),
     Consumer_rate NUMBER(5)
     );

CREATE TABLE cls_departments
    (
     dep_id NUMBER(3),
     department VARCHAR(100),
     Country VARCHAR2(50),
     City VARCHAR2(50),
     StreetAddress VARCHAR2(255),
     StateFull	VARCHAR2(50),
     State_CODE VARCHAR2(2),
     Country_CODE	VARCHAR2(2),
     ZipCode	VARCHAR(20),
     UPS	VARCHAR(30),
     TelephoneNumber VARCHAR(40)
     );


CREATE TABLE cls_PROMOTIONS 
(
	"PROMO_ID" NUMBER(8) NOT NULL,
  "PROMO_CODE" VARCHAR2(50),
	"PROMO_NAME" VARCHAR2(50),
	"PROMO_DESC" VARCHAR2(50),
  "PROMO_COST" NUMBER(8,2),
  "START_DT" DATE,
	"END_DT" DATE,
  "IS_ACTIVE" NUMBER(8,2)
);   

CREATE TABLE cls_SALES
(
	"SALE_ID" NUMBER(8,2) NOT NULL,
	"SALE_DATE" DATE,
	"DEPARTMENT_ID" NUMBER(8,2),
	"CONSUMER_ID" NUMBER(8,2),
	"PRODUCT_ID" NUMBER(8,2),
	"PROMO_ID" NUMBER (8,2),
  "PAY_STATE_ID" NUMBER(8,2)
); 

CREATE TABLE cls_PAYMENTS
(
	"PAYMENT_ID" NUMBER(8,2) NOT NULL,
	"CONSUMER_ID" NUMBER(8,2),
	"SALE_ID" NUMBER(8,2),
	"DEPARTMENT_ID" NUMBER(8,2),
	"COST" NUMBER(8,2),
	"AMOUNT" NUMBER(8,2)
)
;

SELECT * FROM dual;
CREATE TABLE cls_geo_countries (
  country_id number(4),
  country_desc char(200),
  country_code char(3) 
  );

CREATE TABLE cls_geo_structure (
  child_code number (4),
  parent_code number,
  structure_desc char(200),
  structure_level char(200) 
  );
  
CREATE TABLE cls_geo_cntr2structure (
  country_id number(4),
  country_desc char(200),
  structure_code number,
  structure_desc char(200) 
  );

*/
--=========================================================
-- 3nf tables

-- NF_PRODUCT_SUBCATEGORY
execute pkg_drop.DROP_proc('NF_PRODUCT_SUBCATEGORY','table');           
CREATE TABLE NF_PRODUCT_SUBCATEGORY
(
	"SUBCATEGORY_ID" NUMBER(10),
  "SUBCATEGORY_CODE" VARCHAR2(50),
	"SUBCATEGORY_NAME" VARCHAR2(50),
	"CATEGORY_ID" NUMBER(10),
	"SIZE" NUMBER(3),
	"TOBACCO" NUMBER(3,1),
	"UPDATE_DT" DATE,
	"INSERT_DT" DATE DEFAULT SYSDATE
)
;

execute pkg_drop.DROP_proc('seq_product_subcategory','sequence');
CREATE SEQUENCE seq_product_subcategory
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;

-- NF_PRODUCT_CATEGORY
execute pkg_drop.DROP_proc('NF_PRODUCT_CATEGORY','table');   
CREATE TABLE NF_PRODUCT_CATEGORY
(
  "CATEGORY_ID" NUMBER(10),
  "CATEGORY_CODE" VARCHAR2(50),
  "CATEGORY_NAME" VARCHAR2(50),
  "UPDATE_DT" DATE,
  "INSERT_DT" DATE
)
;

execute pkg_drop.DROP_proc('seq_product_category','sequence');
CREATE SEQUENCE seq_product_category
        INCREMENT BY 1 
            START WITH 1 
         MINVALUE 1 
          NOCYCLE;






---- Additional
/*
CREATE TABLE wrk_SALES AS
          SELECT
            seq_sales.nextval AS SALE_ID,
            TO_DATE(TRUNC(DBMS_RANDOM.VALUE(2454467,2462503)),'J') AS DATE_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(dep_id) FROM wrk_DEPARTMENTS)),0) AS DEPARTMENT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(cons_id) FROM wrk_CONSUMERS)),0) AS CONSUMER_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(product_id) FROM wrk_PRODUCTS)), 0) AS PRODUCT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(promo_id) FROM wrk_PROMOTIONS)),0) AS PROMO_ID,
            ROUND(dbms_random.value(1,2)) AS PAY_STATE_ID
          FROM dual
          CONNECT BY level <=5000;
CREATE TABLE wrk_PAYMENTS AS 
          SELECT 
              seq_payments.nextval 
            AS PAYMENT_ID,
              (SELECT ROUND(dbms_random.value(1,900)) || UPPER(dbms_random.string('a',4)) || ROUND(dbms_random.value(1,44))
                FROM dual) 
            AS PAYMENT_CODE,
              (SELECT cons_id FROM
                (SELECT cons_id FROM wrk_consumers
                ORDER BY dbms_random.value )
                WHERE rownum = 1)  
            AS CONSUMER_ID,
              (SELECT sale_id FROM
                ( SELECT sale_id FROM wrk_sales
                ORDER BY dbms_random.value )
                WHERE rownum = 1) 
            AS SALE_ID,
              (SELECT dep_id FROM
                ( SELECT dep_id FROM wrk_departments
                ORDER BY dbms_random.value )
                WHERE rownum = 1)
            AS department_id,     
              ROUND((dbms_random.value ( 0.51, 50.49 ))*(SELECT PROD_PRICE FROM wrk_PRODUCTS WHERE rownum <=1),0)  
            AS AMOUNT,
              ROUND(dbms_random.value ( 0.51, 50.49 ),0) 
            AS QUANTITY
          FROM dual
          CONNECT BY level <=9000;
*/
