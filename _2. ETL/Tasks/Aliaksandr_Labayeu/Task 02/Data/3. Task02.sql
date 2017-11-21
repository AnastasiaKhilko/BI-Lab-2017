-- execute pkg_system.table_insert();

CREATE OR REPLACE PACKAGE pkg_system
  AUTHID CURRENT_USER as
  PROCEDURE table_insert;
END pkg_system;
/

CREATE OR REPLACE PACKAGE BODY pkg_system AS 
  PROCEDURE table_insert AS
      BEGIN
      
        DELETE FROM dim_consumers;
        DELETE FROM dim_departments;
        DELETE FROM dim_promotions;
        DELETE FROM dim_date;
        DELETE FROM dim_sale_state;
        DELETE FROM dim_products;
        DELETE FROM fact_sales;
        
        -- DIM_CONSUMERS
        INSERT INTO dim_consumers (
          CONSUMER_ID,
          CONSUMER_SRC,
          CONSUMER_TITLE,
          ADDRESS,
          CITY,
          COUNTRY,
          REGION,
          PRICE_INDEX,
          POSTAL_CODE,
          PHONE,
          CONSUMER_CODE
          )
        SELECT 
          seq_consumers.nextval, 
          cust_id,
          'Customer' || '-' || ROUND (dbms_random.value (1,9999), 0 ) AS CONSUMER_TITLE,
          CUST_STREET_ADDRESS,
          CUST_CITY,
          COUNTRY_NAME,
          COUNTRY_REGION,
          ROUND ( dbms_random.value (1,2), 0) AS PRICE_INDEX,
          CUST_POSTAL_CODE,
          ROUND (dbms_random.value (1,999999999), 0 ) AS PHONE,
          ROUND (dbms_random.value (1,9), 0 ) AS CONSUMER_CODE
        FROM sh.customers
        INNER JOIN sh.countries USING (COUNTRY_id)
        ;
        
        -- DIM_DEPARTMENT
        INSERT INTO dim_Departments (
          DEPARTMENT_ID,
          DEPARTMENT_SRC,
          DEPARTMENT_CODE,
          ADDRESS,
          CITY,
          COUNTRY,
          REGION,
          POSTAL_CODE
          )
        SELECT 
          seq_departments.nextval,
          DEPARTMENT_ID,
          ROUND (dbms_random.value (1,9999), 0 ) AS DEPARTMENT_CODE,
          STREET_ADDRESS,
          CITY,
          COUNTRY_NAME,
          REGION_NAME,
          POSTAL_CODE
        FROM hr.departments
          LEFT JOIN hr.locations USING (location_id)
          LEFT JOIN HR.countries USING (country_id) 
          LEFT JOIN hr.regions USING (region_id)
        ;

        -- DIM_DATE
        INSERT INTO dim_date (
          DATE_ID,
          DAY_WEEK,
          DAY_SHORT,
          DAY_LONG,
          DAY_MONTH,
          LASTDAY_MONTH,
          DAY_YEAR,
          MONTH_YEAR,
          MONTH_SHORT,
          MONTH_LONG,
          MONTH_DESC,
          QUARTER,
          YEAR_HALF,
          YEAR
          )
        SELECT
          TO_DATE('31/12/2007','DD/MM/YYYY') + n AS DATE_ID,
          TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'d')) AS Day_Week,
          UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Dy')) AS Day_Short,
          TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DAY') AS Day_Long,
          TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DD')) AS Day_Month,
          LAST_DAY(TO_DATE('31/12/1999','DD/MM/YYYY') + n) AS LastDay_Month,
          TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'DDD')) AS Day_Year,
          TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM')) AS Month_Year,
          UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Mon')) AS Month_Short,
          UPPER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Month')) AS Month_Long,
          TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'YYYY') || '-' || 
            TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'MM') AS Month_Desc,
          TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n, 'Q')) AS Quarter,
          CASE
            WHEN EXTRACT(MONTH FROM (TO_DATE('31/12/1999','DD/MM/YYYY') + n)) <=6 THEN '1'
            ELSE '2'
          END
        AS Year_Half,
        TO_NUMBER(TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + n,'YYYY')) AS Year
        FROM (
        select level n
        from dual
        connect by level <= 10959
        );
        
        -- DIM_PRODUCTS
        INSERT INTO DIM_PRODUCTS (
          PRODUCT_ID,
          PRODUCT_SRC,
          PRODUCT_CODE,
          PRODUCT_NAME,
          PRODUCT_CATEGORY,
          PRODUCT_SUBCATEGORY,
          PACKAGE_SIZE,
          PACKAGE_COLOR,
          ITEM_SIZE,
          TOBACCO,
          ITEMS_PACKAGE,
          PRODUCT_IMAGE,
          LOCALIZATION,
          START_DT,
          END_DT,
          IS_ACTIVE,
          STD_PRICE)
        SELECT 
          seq_products.nextval AS PRODUCT_ID,
          PROD_ID AS PRODUCT_SRC,
          ROUND (dbms_random.value (1,99999), 0 ) AS PRODUCT_CODE,
          PROD_NAME,
          PROD_CATEGORY,
          PROD_SUBCATEGORY_DESC,
          ROUND (dbms_random.value (1,5), 0 ) AS PACKAGE_SIZE,
          TO_CHAR( TRUNC( DBMS_RANDOM.VALUE( 0, 256*256*256 ) ), 'FM0XXXXX' ) AS PACKAGE_COLOR,
          ROUND (dbms_random.value (1,5), 0 ) AS ITEM_SIZE,
          TO_CHAR (dbms_random.string('w',5)) AS TOBACCO,
          ROUND (dbms_random.value (1,5), 0 ) || 'x' || ROUND (dbms_random.value (1,5), 0 ) AS ITEMS_PACKAGE,
          ROUND (dbms_random.value (1,5)) AS PACKAGE_SIZE,
          DECODE (ROUND(dbms_random.value (1,2),0), 1, 'local', 'global') AS LOCALIZATION,
          TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS START_DT,
          TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS END_DT,
          DECODE (ROUND(dbms_random.value (1,2),0), 1, 'active', 'non-active') AS IS_ACTIVE,
          ROUND (dbms_random.value (1,34), 0 ) AS STD_PRICE
          FROM sh.products;
        
        -- DIM_PROMOTIONS
        INSERT INTO DIM_PROMOTIONS (
          PROMO_ID,
          PROMO_SRC,
          PROMO_NAME,
          PROMO_DESC,
          PROMO_TYPE,
          PROMO_COST,
          PROMO_CODE,
          START_DT,
          END_DT,
          IS_ACTIVE)
        SELECT 
          seq_promotions.nextval AS PROMO_ID,
          PROMO_ID AS PROMO_SRC,
          dbms_random.string('b',10) || ' ' || ROUND(dbms_random.value(4, 99)) AS PROMO_NAME,
          PROMO_NAME AS PROMO_DESC,
          PROMO_CATEGORY AS PROMO_TYPE,
          PROMO_COST AS PROMO_COST,
          ROUND (dbms_random.value (1,99999), 0 ) AS PROMO_CODE,
          TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS START_DT,
          TO_DATE (TRUNC (DBMS_RANDOM.VALUE (2451545, 5373484)), 'J') AS END_DT,
          DECODE (ROUND(dbms_random.value (1,2),0), 1, 'active', 'non-active') AS IS_ACTIVE
        FROM SH.PROMOTIONS;
        
        -- DIM_SALE_STATE
        INSERT ALL
          INTO DIM_SALE_STATE (STATE_ID, STATE_DESC) VALUES ('1', 'Not paid')
          INTO DIM_SALE_STATE (STATE_ID, STATE_DESC) VALUES ('2','Partialy paid')
          INTO DIM_SALE_STATE (STATE_ID, STATE_DESC) VALUES ('3','Fully paid')
        SELECT 1 FROM dual;  
        
        /*
        SELECT * FROM dim_products ORDER BY 1; +
        SELECT * FROM dim_consumers ORDER BY 1; +
        SELECT * FROM dim_date ORDER BY 1; +
        SELECT * FROM dim_promotions ORDER BY 1; +
        SELECT * FROM dim_departments ORDER BY 1; +
        SELECT * FROM dim_sale_state; +
        SELECT COUNT(*) FROM FACT_SALES;
        
        SELECT TO_CHAR(TO_DATE('01/01/08','mm/dd/yy'),'J') FROM dual; -- 2454467
        SELECT TO_CHAR(TO_DATE('01/01/2030','mm/dd/yy'),'J') FROM dual; -- 2462503
        SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(2454467,2462503)),'J') FROM dual;
        */
        
        -- FACT_SALES
        BEGIN 
          FOR i IN 1..50
          LOOP
            dbms_random.seed (i * 5);
          INSERT INTO FACT_SALES (
            PRODUCT_ID,
            DEPARTMENT_ID,
            CONSUMER_ID,
            PROMO_ID,
            AMOUNT,
            QUANTITY,
            DATE_ID,
            STATE_ID
            )
          SELECT 
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(product_id) FROM DIM_PRODUCTS)), 0) AS PRODUCT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(department_id) FROM DIM_DEPARTMENTS)),0) AS DEPARTMENT_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(consumer_id) FROM DIM_CONSUMERS)),0) AS CONSUMER_ID,
            ROUND(dbms_random.value ( 0.51, (SELECT MAX(promo_id) FROM DIM_PROMOTIONS)),0) AS PROMO_ID,
            ROUND(dbms_random.value ( 0.51, 50.49 ),0)*(SELECT STD_PRICE FROM DIM_PRODUCTS WHERE rownum <=1)  AS AMOUNT,
            ROUND(dbms_random.value ( 0.51, 50.49 ),0) AS QUANTITY,
            TO_DATE(TRUNC(DBMS_RANDOM.VALUE(2454467,2462503)),'J') AS DATE_ID,
            ROUND(dbms_random.value(1,2)) AS STATE_ID
          FROM dual
          CONNECT BY level <=500;
          END LOOP;
        END;

      COMMIT;
    END;
END pkg_system;
/