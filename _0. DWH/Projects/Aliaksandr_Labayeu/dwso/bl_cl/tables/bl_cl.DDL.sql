-- DROPPING synonyms
execute pkg_drop.DROP_Proc ('EXT_GEO_countries','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_STRUCTURE','synonym');
execute pkg_drop.DROP_Proc ('EXT_GEO_cntr2structure','synonym');
execute pkg_drop.DROP_Proc ('EXT_PRODUCTS','synonym');
execute pkg_drop.DROP_Proc ('EXT_CONSUMERS','synonym');
execute pkg_drop.DROP_Proc ('EXT_DEPARTMENTS','synonym');

-- DROPPING tables
execute pkg_drop.DROP_Proc('wrk_geo_countries','table');
execute pkg_drop.DROP_Proc('wrk_geo_structure','table');
execute pkg_drop.DROP_Proc('wrk_geo_cntr2structure','table');
execute pkg_drop.DROP_Proc('wrk_products','table');
execute pkg_drop.DROP_Proc('wrk_consumers','table');
execute pkg_drop.DROP_Proc('wrk_departments','table');
execute pkg_drop.DROP_Proc('wrk_promotions','table');
execute pkg_drop.DROP_Proc('wrk_sales','table');

execute pkg_drop.DROP_Proc('cls_geo_countries','table');
execute pkg_drop.DROP_Proc('cls_geo_structure','table');
execute pkg_drop.DROP_Proc('cls_geo_cntr2structure','table');
execute pkg_drop.DROP_Proc('cls_products','table');
execute pkg_drop.DROP_Proc('cls_consumers','table');
execute pkg_drop.DROP_Proc('cls_departments','table');
execute pkg_drop.DROP_Proc('cls_promotions','table');
execute pkg_drop.DROP_Proc('cls_sales','table');

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

--==========================================================================================
-- Creating Tables
-- Working tables
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
          
CREATE TABLE wrk_geo_countries AS SELECT * FROM EXT_GEO_countries;
CREATE TABLE wrk_geo_structure AS SELECT * FROM EXT_GEO_STRUCTURE;
CREATE TABLE wrk_geo_cntr2structure AS SELECT * FROM EXT_GEO_cntr2structure;
CREATE TABLE wrk_products AS SELECT * FROM EXT_PRODUCTS;
CREATE TABLE wrk_consumers AS SELECT * FROM EXT_CONSUMERS;
CREATE TABLE wrk_departments AS SELECT * FROM EXT_DEPARTMENTS;
CREATE TABLE wrk_PROMOTIONS AS 
          SELECT
            PROMO_ID AS PROMO_ID,
            ROUND (dbms_random.value (1,99999), 0 ) AS PROMO_CODE,
            'Promotion ' || dbms_random.string('b',4) || ROUND(dbms_random.value(4, 99)) AS PROMO_NAME,
            PROMO_NAME AS PROMO_DESC,
            PROMO_COST AS PROMO_COST,
            TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS START_DT,
            TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS END_DT,
            ROUND(dbms_random.value (1,2),0) AS IS_ACTIVE
          FROM SH.PROMOTIONS;
       
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
            ROUND(dbms_random.value ( 0.51, 50.49 ),0)*(SELECT PROD_PRICE FROM wrk_PRODUCTS WHERE rownum <=1)  AS AMOUNT,
            ROUND(dbms_random.value ( 0.51, 50.49 ),0) AS QUANTITY
          FROM dual
          CONNECT BY level <=9000;
SELECT cons_id FROM
( SELECT cons_id FROM wrk_consumers
ORDER BY dbms_random.value )
WHERE rownum = 1      ;   
-- SELECT * FROM wrk_payments;



-- cls tables

CREATE TABLE cls_geo_countries (
  country_id number(4),
  country_desc char(200),
  country_code char(3) 
  );

CREATE TABLE cls_geo_structure (
  Achild_code number (4),
  parent_code number,
  structure_desc char(200),
  structure_level char(200) 
  );
  
CREATE TABLE cls_geo_cntr2structure (
  country_id number(4),
  county_desc char(200),
  structure_code number,
  structure_desc char(200) 
  );

CREATE TABLE cls_products
    (
    product_id NUMBER(3),
    product VARCHAR2(100),
    prod_category VARCHAR2(100),
    subcategory VARCHAR2(100),
    localization VARCHAR2(100),
    tobacco NUMBER(8,2),
    prod_size NUMBER(4),
    prod_price NUMBER(8,2)
    );

CREATE TABLE cls_consumers
    (
     cons_id NUMBER(5),
     gender VARCHAR2(10),
     FullName VARCHAR2(255),
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
     WesternUnionMTCN	NUMBER(10),
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

--=========================================================
-- 3nf tables

CREATE TABLE "BL_3NF"."ADDRESSES"
(
	"ADDRESS_ID" NUMBER(8,2) NOT NULL,
	"ADDRESS" VARCHAR2(50),
	"POSTAL_CODE" VARCHAR2(50),
	"PHONE" VARCHAR2(50),
	"CITY_ID" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."CITIES"
(
	"CITY_ID" NUMBER(8,2) NOT NULL,
	"CITY" VARCHAR2(50),
	"COUNTRY_ID" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."CONSUMER_RATE"
(
	"CONSUMER_RATE_ID" NUMBER(8,2) NOT NULL,
	"RATE_TITLE" VARCHAR2(50)
)
;

CREATE TABLE "BL_3NF"."CONSUMERS"
(
	"CONSUMER_ID" NUMBER(8,2) NOT NULL,
	"CONSUMER_CODE" NUMBER(8,2),
	"CONSUMER_TITLE" VARCHAR2(50),
	"CONSUMER_RATE_ID" NUMBER(8,2),
	"ADDRESS_ID" NUMBER(8,2),
	"RESPONSIBLE_ID" NUMBER(8,2),
	"RESP_ID" NUMBER
)
;

CREATE TABLE "BL_3NF"."COUNTRIES"
(
	"COUNTRY_ID" NUMBER(8,2) NOT NULL,
	"COUNTRY_CODE" NUMBER(8,2),
	"COUNTY" VARCHAR2(50),
	"REGION_ID" NUMBER(8,2),
	"CITY_ID" NUMBER
)
;

CREATE TABLE "BL_3NF"."DEPARTMENTS"
(
	"DEPARTMENT_ID" NUMBER(8,2) NOT NULL,
	"DEPARTMENT_CODE" NUMBER(8,2),
	"DEPARTMENT_DESC" VARCHAR2(50),
	"ADDRESS_ID" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."LOCALIZATION"
(
	"LOCALIZATION_ID" NUMBER(8,2) NOT NULL,
	"LOCALIZATION_NAME" VARCHAR2(50)
)
;

CREATE TABLE "BL_3NF"."PACKAGE"
(
	"PACKAGE_ID" NUMBER(8,2) NOT NULL,
	"PACKAGE_CODE" VARCHAR2(50),
	"SIZE" VARCHAR2(50),
	"COLOR" VARCHAR2(50),
	"ITEMS_PACKAGE" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."PAY_STATE"
(
	"PAY_STATE_ID" NUMBER(8,2) NOT NULL,
	"PAY_STATE_NAME" VARCHAR2(50)
)
;
DROP TABLE payments;
CREATE TABLE "BL_3NF"."PAYMENTS"
(
	"PAYMENT_ID" NUMBER(8,2) NOT NULL,
	"CONSUMER_ID" NUMBER(8,2),
	"SALE_ID" NUMBER(8,2),
	"DEPARTMENT_ID" NUMBER(8,2),
	"COST" NUMBER(8,2),
	"AMOUNT" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."PRODUCT_CATEGORY"
(
	"CATEGORY_ID" NUMBER(8,2) NOT NULL,
	"CATEGORY_NAME" VARCHAR2(50),
	"SUBCATEGORY_ID" NUMBER
)
;

CREATE TABLE "BL_3NF"."PRODUCT_SUBCATEGORY"
(
	"SUBCATEGORY_ID" NUMBER(8,2) NOT NULL,
	"SUBCATEGORY_NAME" VARCHAR2(50),
	"CATEGORY_ID" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."PRODUCTS"
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

CREATE TABLE "BL_3NF"."PROMOTIONS"
(
	"PROMO_ID" NUMBER(8,2) NOT NULL,
	"PROMO_NAME" VARCHAR2(50),
	"PROMO_DESC" VARCHAR2(50),
	"START_DT" DATE,
	"END_DT" DATE,
	"PROMO_COST" NUMBER(8,2),
	"PROMO_CODE" VARCHAR2(50),
	"IS_ACTIVE" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."REGIONS"
(
	"REGION_ID" NUMBER(8,2) NOT NULL,
	"REGION_NAME" VARCHAR2(50),
	"COUNTRY_ID" NUMBER
)
;

CREATE TABLE "BL_3NF"."RESPONSIBLE"
(
	"RESP_ID" NUMBER(8,2) NOT NULL,
	"FIRST_NAME" VARCHAR2(50),
	"LAST_NAME" VARCHAR2(50),
	"PHONE" VARCHAR2(50),
	"EMAIL" VARCHAR2(50),
	"BIRTHDAY" DATE,
	"AGE" NUMBER(8,2)
)
;

CREATE TABLE "BL_3NF"."SALES"
(
	"SALE_ID" NUMBER(8,2) NOT NULL,
	"SALE_DATE" DATE,
	"DEPARTMENT_ID" NUMBER(8,2),
	"CONSUMER_ID" NUMBER(8,2),
	"PRODUCT_ID" NUMBER(8,2),
	"PAY_STATE_ID" NUMBER(8,2),
	"PROMO_ID" NUMBER
)
;

ALTER TABLE "BL_3NF"."ADDRESSES" 
 ADD CONSTRAINT "PK_ADDRESSES"
	PRIMARY KEY ("ADDRESS_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."CITIES" 
 ADD CONSTRAINT "PK_CITIES"
	PRIMARY KEY ("CITY_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."CONSUMER_RATE" 
 ADD CONSTRAINT "PK_CONSUMER_RAT_01"
	PRIMARY KEY ("CONSUMER_RATE_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."CONSUMERS" 
 ADD CONSTRAINT "PK_CONSUMERS"
	PRIMARY KEY ("CONSUMER_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."COUNTRIES" 
 ADD CONSTRAINT "PK_COUNTRIES"
	PRIMARY KEY ("COUNTRY_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."DEPARTMENTS" 
 ADD CONSTRAINT "PK_DEPARTMENTS"
	PRIMARY KEY ("DEPARTMENT_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."LOCALIZATION" 
 ADD CONSTRAINT "PK_LOCALIZATION"
	PRIMARY KEY ("LOCALIZATION_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PACKAGE" 
 ADD CONSTRAINT "PK_PACKAGE"
	PRIMARY KEY ("PACKAGE_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PAY_STATE" 
 ADD CONSTRAINT "PK_PAY_STATE"
	PRIMARY KEY ("PAY_STATE_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PAYMENTS" 
 ADD CONSTRAINT "PK_PAYMENTS"
	PRIMARY KEY ("PAYMENT_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PRODUCT_CATEGORY" 
 ADD CONSTRAINT "PK_PRODUCT_CATEGORY"
	PRIMARY KEY ("CATEGORY_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PRODUCT_SUBCATEGORY" 
 ADD CONSTRAINT "PK_PRODUCT_SUBC_01"
	PRIMARY KEY ("SUBCATEGORY_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PRODUCTS" 
 ADD CONSTRAINT "PK_PRODUCTS"
	PRIMARY KEY ("PRODUCT_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."PROMOTIONS" 
 ADD CONSTRAINT "PK_PROMOTIONS"
	PRIMARY KEY ("PROMO_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."REGIONS" 
 ADD CONSTRAINT "PK_REGIONS"
	PRIMARY KEY ("REGION_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."RESPONSIBLE" 
 ADD CONSTRAINT "PK_RESPONSIBLE"
	PRIMARY KEY ("RESP_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "PK_SALES"
	PRIMARY KEY ("SALE_ID") USING INDEX
;

ALTER TABLE "BL_3NF"."ADDRESSES" 
 ADD CONSTRAINT "FK_ADDRESSES_CITIES"
	FOREIGN KEY ("CITY_ID") REFERENCES "BL_3NF"."CITIES" ("CITY_ID")
;

ALTER TABLE "BL_3NF"."CITIES" 
 ADD CONSTRAINT "FK_CITIES_COUNTRIES"
	FOREIGN KEY ("COUNTRY_ID") REFERENCES "BL_3NF"."COUNTRIES" ("COUNTRY_ID")
;

ALTER TABLE "BL_3NF"."CONSUMERS" 
 ADD CONSTRAINT "FK_CONSUMERS_ADDRESSES"
	FOREIGN KEY ("ADDRESS_ID") REFERENCES "BL_3NF"."ADDRESSES" ("ADDRESS_ID")
;

ALTER TABLE "BL_3NF"."CONSUMERS" 
 ADD CONSTRAINT "FK_CONSUMERS_CONSUMER_RATE"
	FOREIGN KEY ("CONSUMER_RATE_ID") REFERENCES "BL_3NF"."CONSUMER_RATE" ("CONSUMER_RATE_ID")
;

ALTER TABLE "BL_3NF"."CONSUMERS" 
 ADD CONSTRAINT "FK_CONSUMERS_RESPONSIBLE"
	FOREIGN KEY ("RESP_ID") REFERENCES "BL_3NF"."RESPONSIBLE" ("RESP_ID")
;

ALTER TABLE "BL_3NF"."COUNTRIES" 
 ADD CONSTRAINT "FK_COUNTRIES_REGIONS"
	FOREIGN KEY ("REGION_ID") REFERENCES "BL_3NF"."REGIONS" ("REGION_ID")
;

ALTER TABLE "BL_3NF"."DEPARTMENTS" 
 ADD CONSTRAINT "FK_DEPARTMENTS_ADDRESSES"
	FOREIGN KEY ("ADDRESS_ID") REFERENCES "BL_3NF"."ADDRESSES" ("ADDRESS_ID")
;

ALTER TABLE "BL_3NF"."PAYMENTS" 
 ADD CONSTRAINT "FK_PAYMENTS_SALES"
	FOREIGN KEY ("SALE_ID") REFERENCES "BL_3NF"."SALES" ("SALE_ID")
;

ALTER TABLE "BL_3NF"."PRODUCT_CATEGORY" 
 ADD CONSTRAINT "FK_PRODUCT_CATE_PRODUCT_SUB_01"
	FOREIGN KEY ("SUBCATEGORY_ID") REFERENCES "BL_3NF"."PRODUCT_SUBCATEGORY" ("SUBCATEGORY_ID")
;

ALTER TABLE "BL_3NF"."PRODUCTS" 
 ADD CONSTRAINT "FK_PRODUCTS_LOCALIZATION"
	FOREIGN KEY ("LOCALIZATION_ID") REFERENCES "BL_3NF"."LOCALIZATION" ("LOCALIZATION_ID")
;

ALTER TABLE "BL_3NF"."PRODUCTS" 
 ADD CONSTRAINT "FK_PRODUCTS_PACKAGE"
	FOREIGN KEY ("PACKAGE_ID") REFERENCES "BL_3NF"."PACKAGE" ("PACKAGE_ID")
;

ALTER TABLE "BL_3NF"."PRODUCTS" 
 ADD CONSTRAINT "FK_PRODUCTS_PRODUCT_CATEGORY"
	FOREIGN KEY ("CATEGORY_ID") REFERENCES "BL_3NF"."PRODUCT_CATEGORY" ("CATEGORY_ID")
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "FK_SALES_CONSUMERS"
	FOREIGN KEY ("CONSUMER_ID") REFERENCES "BL_3NF"."CONSUMERS" ("CONSUMER_ID")
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "FK_SALES_DEPARTMENTS"
	FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "BL_3NF"."DEPARTMENTS" ("DEPARTMENT_ID")
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "FK_SALES_PAY_STATE"
	FOREIGN KEY ("PAY_STATE_ID") REFERENCES "BL_3NF"."PAY_STATE" ("PAY_STATE_ID")
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "FK_SALES_PRODUCTS"
	FOREIGN KEY ("PRODUCT_ID") REFERENCES "BL_3NF"."PRODUCTS" ("PRODUCT_ID")
;

ALTER TABLE "BL_3NF"."SALES" 
 ADD CONSTRAINT "FK_SALES_PROMOTIONS"
	FOREIGN KEY ("PROMO_ID") REFERENCES "BL_3NF"."PROMOTIONS" ("PROMO_ID")
;




