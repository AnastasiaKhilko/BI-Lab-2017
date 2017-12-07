--==========================================================================================
-- Creating Tables
-- Working tables
--==========================================================================================
CREATE OR REPLACE SYNONYM EXT_PRODUCTS FOR sa_src.ext_products;
CREATE OR REPLACE SYNONYM EXT_CONSUMERS FOR sa_src.ext_consumers;
CREATE OR REPLACE SYNONYM EXT_DEPARTMENTS FOR sa_src.ext_departments;
CREATE OR REPLACE SYNONYM EXT_LOCATIONS FOR sa_src.EXT_LOCATIONS;

CREATE TABLE wrk_products AS SELECT * FROM EXT_PRODUCTS;
CREATE TABLE wrk_consumers AS SELECT * FROM EXT_CONSUMERS;
CREATE TABLE wrk_departments AS SELECT * FROM EXT_DEPARTMENTS;
CREATE TABLE wrk_locations AS SELECT * FROM EXT_LOCATIONS;
CREATE TABLE wrk_PROMOTIONS parallel 4 AS 
          SELECT
            ROUND (dbms_random.value (1,99), 0 ) || dbms_random.string('b',2) || ROUND (dbms_random.value (1,99), 0 ) AS PROMO_CODE,
            'Promotion ' || dbms_random.string('b',4) || ROUND(dbms_random.value(4, 99)) AS PROMO_NAME,
            PROMO_NAME AS PROMO_DESC,
            PROMO_COST AS PROMO_COST
          FROM SH.PROMOTIONS;   

