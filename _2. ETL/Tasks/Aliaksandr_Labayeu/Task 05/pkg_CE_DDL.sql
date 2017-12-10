--==========================================================
--== 3 NF ==================================================
--==========================================================

CREATE OR REPLACE PACKAGE CE_DDL
  AUTHID CURRENT_USER as
  PROCEDURE CE_REGIONS;
  PROCEDURE CE_SUBREGIONS;
  PROCEDURE CE_LOCALIZATION;
  PROCEDURE CE_COUNTRIES;
  PROCEDURE CE_CITIES;
  PROCEDURE CE_ADDRESSES;
  PROCEDURE CE_PRODUCTS;
  PROCEDURE CE_PRODUCT_CATEGORY;
  PROCEDURE CE_PRODUCT_SUBCATEGORY;
  PROCEDURE CE_CONSUMERS;
  PROCEDURE CE_DEPARTMENTS;
  PROCEDURE CE_SALES;
  PROCEDURE CE_OCCUPATION;
  PROCEDURE CE_CONSUMER_RATE;
  PROCEDURE CE_RESPONSIBLE;
  PROCEDURE CE_PROMOTIONS;
END CE_DDL;
/

CREATE OR REPLACE PACKAGE BODY CE_DDL AS 


-- CE_REGIONS
PROCEDURE CE_REGIONS AS
BEGIN

MERGE INTO ce_REGIONS ce
USING (
  SELECT REGION_CODE, REGION_NAME FROM cls_REGIONS
  MINUS
  SELECT REGION_CODE, REGION_NAME FROM ce_regions
  ) cl
ON (ce.region_code = cl.region_code)
WHEN MATCHED 
  THEN UPDATE
    SET 
      ce.region_name = cl.region_name,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_regions.nextval,
      cl.region_code,
      cl.region_name,
      sysdate,
      sysdate
      );
COMMIT;
END;

-- CE_SUBREGIONS
PROCEDURE CE_SUBREGIONS AS
BEGIN
MERGE INTO ce_SUBREGIONS ce
USING(
  SELECT SUBREGION_CODE, SUBREGION_NAME, REGION_ID FROM CLS_SUBREGIONS s
    LEFT JOIN CE_REGIONS r ON r.region_code = s.region_code
  MINUS
  SELECT SUBREGION_CODE, SUBREGION_NAME, REGION_ID FROM CE_SUBREGIONS
  ) cl
ON (ce.subregion_code = cl.subregion_code)
WHEN MATCHED
  THEN UPDATE
    SET
      ce.SUBREGION_NAME = cl.SUBREGION_NAME, 
      ce.REGION_ID = cl.REGION_ID,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_subregions.nextval,
      cl.subregion_code,
      cl.subregion_name,
      cl.region_id,
      sysdate,
      sysdate);
COMMIT;
END;

 -- CE_COUNTRIES
PROCEDURE CE_COUNTRIES AS
BEGIN
MERGE INTO ce_COUNTRIES ce
USING (
  SELECT COUNTRY_CODE2, COUNTRY_CODE3, COUNTRY_NAME, SUBREGION_ID FROM cls_countries c
  LEFT JOIN ce_SUBREGIONS s ON c.subregion_code = s.subregion_code
  MINUS
  SELECT COUNTRY_CODE2, COUNTRY_CODE3, COUNTRY_NAME, SUBREGION_ID FROM ce_countries 
  ) cl
ON (ce.COUNTRY_CODE2 = cl.COUNTRY_CODE2)
WHEN MATCHED
  THEN UPDATE
    SET
      ce.COUNTRY_CODE3 = cl.COUNTRY_CODE3, 
      ce.COUNTRY_NAME = cl.COUNTRY_NAME, 
      ce.SUBREGION_ID = cl.SUBREGION_ID,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_countries.nextval,
      cl.COUNTRY_CODE2, 
      cl.COUNTRY_CODE3, 
      cl.COUNTRY_NAME, 
      cl.SUBREGION_ID,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_CITIES
PROCEDURE CE_CITIES AS
BEGIN
MERGE INTO  ce_CITIES ce
USING (
  SELECT CITY_CODE, CITY_NAME, COUNTRY_ID FROM CLS_CITIES cl
    LEFT JOIN CE_COUNTRIES cc ON cc.country_code2 = cl.country_code
  MINUS
  SELECT CITY_CODE, CITY_NAME, COUNTRY_ID FROM CE_CITIES
  ) cl
ON (cl.CITY_CODE = ce.CITY_CODE )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.CITY_NAME = cl.city_name,
      ce.COUNTRY_ID = cl.country_id,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_cities.nextval,
      cl.CITY_CODE,
      cl.CITY_NAME,
      cl.COUNTRY_ID,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_ADDRESSES
PROCEDURE CE_ADDRESSES AS
BEGIN
MERGE INTO CE_ADDRESSES ce
USING (
  SELECT ADDRESS_CODE, ADDRESS, POSTAL_CODE, PHONE, CITY_ID FROM CLS_ADDRESSES ca
    INNER JOIN CE_CITIES cec ON cec.CITY_CODE =  ca.CITY_code
  MINUS
  SELECT ADDRESS_CODE, ADDRESS, POSTAL_CODE, PHONE, CITY_ID FROM CE_ADDRESSES
  ) cl
ON (cl.ADDRESS_CODE = ce.ADDRESS_CODE )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.ADDRESS = cl.ADDRESS, 
      ce.POSTAL_CODE = cl.POSTAL_CODE, 
      ce.PHONE = cl.PHONE, 
      ce.CITY_ID = cl.CITY_ID,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_addresses.nextval,
      cl.ADDRESS_CODE, 
      cl.ADDRESS, 
      cl.POSTAL_CODE, 
      cl.PHONE, 
      cl.CITY_ID,
      sysdate,
      sysdate);  
COMMIT;
END;


-- CE_DEPARTMENTS
PROCEDURE CE_DEPARTMENTS AS
BEGIN
MERGE INTO CE_DEPARTMENTS ce
  USING (SELECT * FROM cls_departments cd LEFT JOIN CE_ADDRESSES cea ON cea.ADDRESS_CODE = cd.ADDRESS_CODE 
   WHERE address IS NOT NULL) cl
    ON (
      cl.department_code = ce.department_code AND
      cl.start_dt = ce.start_dt
      )
  WHEN MATCHED
    THEN UPDATE
      SET
        ce.DEPARTMENT_DESC = cl.DEPARTMENT_DESC,
        ce.ADDRESS_ID = cl.ADDRESS_ID,
        ce.END_DT = cl.END_DT
  WHEN NOT MATCHED
    THEN INSERT
      VALUES (
        seq_departments.nextval,
        cl.DEPARTMENT_CODE, 
        cl.DEPARTMENT_DESC, 
        cl.ADDRESS_ID,
        cl.START_DT,
        cl.END_DT,
        cl.IS_ACTIVE,
        sysdate,
        sysdate
      );
COMMIT;
END;

-- CE_PRODUCT_CATEGORY
PROCEDURE CE_PRODUCT_CATEGORY AS
BEGIN
MERGE INTO ce_PRODUCT_CATEGORY ce
USING (
  SELECT category_code, category_name FROM CLS_PRODUCT_CATEGORY 
  MINUS 
  SELECT category_code, category_name FROM ce_PRODUCT_CATEGORY
  ) cl
ON (ce.category_code = cl.category_code)
WHEN MATCHED 
  THEN UPDATE 
    SET
      ce.CATEGORY_NAME = cl.CATEGORY_NAME,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT 
      VALUES (
        seq_product_category.nextval,
        cl.CATEGORY_CODE,
        cl.CATEGORY_NAME, 
        SYSDATE,
        SYSDATE
        );
COMMIT;
END;

-- CE_PRODUCT_SUBCATEGORY
PROCEDURE CE_PRODUCT_SUBCATEGORY AS
BEGIN
MERGE INTO ce_PRODUCT_SUBCATEGORY ce
USING (
  SELECT SUBCATEGORY_CODE, SUBCATEGORY_NAME, category_id, "SIZE", tobacco FROM CLS_PRODUCT_SUBCATEGORY cls 
      LEFT JOIN ce_PRODUCT_CATEGORY ce_c ON cls.category_code = ce_c.category_code
  MINUS
  SELECT SUBCATEGORY_CODE, SUBCATEGORY_NAME, category_id, "SIZE", tobacco FROM ce_PRODUCT_SUBCATEGORY ce 
  ) cl
ON (ce.subcategory_code = cl.subcategory_code)
WHEN MATCHED
  THEN UPDATE
    SET
      ce.SUBCATEGORY_NAME = cl.SUBCATEGORY_NAME,
      ce."SIZE" = cl."SIZE",
      ce.tobacco = cl.tobacco,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT 
      VALUES (
        seq_product_subcategory.nextval,
        cl.SUBCATEGORY_CODE,
        cl.SUBCATEGORY_NAME, 
        cl.category_id,
        cl."SIZE",
        cl.tobacco,
        sysdate,
        sysdate
        );
COMMIT;
END;

-- CE_LOCALIZATION
PROCEDURE CE_LOCALIZATION AS
BEGIN
EXECUTE IMMEDIATE ('TRUNCATE TABLE "BL_3NF"."CE_CONSUMER_RATE"');
INSERT INTO ce_localization SELECT * FROM cls_localization;
COMMIT;
END;

-- CE_PRODUCTS
PROCEDURE CE_PRODUCTS AS
BEGIN
MERGE INTO ce_PRODUCTS ce
USING (
  SELECT PRODUCT_CODE, PRODUCT_NAME, LOCALIZATION_ID, CATEGORY_ID, PRICE FROM CLS_PRODUCTS cp
    LEFT JOIN CE_LOCALIZATION cel ON  cel.localization_name = cp.localization_code
    LEFT JOIN CE_PRODUCT_CATEGORY cepc ON cepc.CATEGORY_CODE = cp.CATEGORY_CODE
    WHERE PRODUCT_CODE IS NOT NULL
  MINUS
  SELECT PRODUCT_CODE, PRODUCT_NAME, LOCALIZATION_ID, CATEGORY_ID, PRICE FROM CE_PRODUCTS cep
    WHERE PRODUCT_CODE IS NOT NULL
  ) cl
ON ( cl.product_code = ce.product_code )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.PRODUCT_NAME = cl.PRODUCT_NAME,
      ce.LOCALIZATION_ID = cl.LOCALIZATION_ID,
      ce.CATEGORY_ID = cl.CATEGORY_ID, 
      ce.PRICE = cl.PRICE,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_product.nextval,
      cl.PRODUCT_CODE, 
      cl.PRODUCT_NAME, 
      cl.LOCALIZATION_ID, 
      cl.CATEGORY_ID,
      cl.PRICE,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_CONSUMER_RATE
PROCEDURE CE_CONSUMER_RATE AS
BEGIN
EXECUTE IMMEDIATE ('TRUNCATE TABLE "BL_3NF"."CE_CONSUMER_RATE"'); 
INSERT INTO ce_consumer_rate SELECT * FROM cls_consumer_rate;
COMMIT;
END;

-- CE_OCCUPATION
PROCEDURE CE_OCCUPATION AS
BEGIN
MERGE INTO  ce_OCCUPATION ce
USING (
  SELECT OCCUPATION_CODE, OCCUPATION_NAME FROM CLS_OCCUPATION
  MINUS
  SELECT OCCUPATION_CODE, OCCUPATION_NAME FROM ce_OCCUPATION 
  ) cl
ON ( cl.occupation_code = ce.OCCUPATION_CODE )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.OCCUPATION_NAME = cl.OCCUPATION_NAME,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_occupation.nextval,
      cl.OCCUPATION_CODE, 
      cl.OCCUPATION_NAME,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_RESPONSIBLE
PROCEDURE CE_RESPONSIBLE AS
BEGIN
MERGE INTO  ce_RESPONSIBLE ce
USING (
  SELECT 
    RESP_CODE,
    FIRST_NAME,
    LAST_NAME,
    PHONE,
    EMAIL,
    BIRTHDAY,
    AGE,
    OCCUPATION_ID
  FROM cls_RESPONSIBLE cr
  LEFT JOIN ce_OCCUPATION ceo ON ceo.OCCUPATION_CODE = cr.OCCUPATION_CODE
  MINUS
  SELECT
    RESP_CODE,
    FIRST_NAME,
    LAST_NAME,
    PHONE,
    EMAIL,
    BIRTHDAY,
    AGE,
    OCCUPATION_ID
  FROM ce_RESPONSIBLE
  ) cl
ON ( cl.RESP_CODE = ce.RESP_CODE )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.FIRST_NAME = cl.FIRST_NAME,
      ce.LAST_NAME = cl.LAST_NAME,
      ce.PHONE = ce.PHONE,
      ce.EMAIL = cl.EMAIL,
      ce.BIRTHDAY = cl.EMAIL,
      ce.AGE = cl.AGE,
      ce.OCCUPATION_ID = cl.OCCUPATION_ID,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_responsible.nextval,
      cl.RESP_CODE,
      cl.FIRST_NAME,
      cl.LAST_NAME,
      cl.PHONE,
      cl.EMAIL,
      cl.BIRTHDAY,
      cl.AGE,
      cl.OCCUPATION_ID,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_CONSUMERS
PROCEDURE CE_CONSUMERS AS
BEGIN
MERGE INTO  ce_CONSUMERS ce
USING (
  SELECT 
    CONSUMER_CODE,
    CONSUMER_TITLE,
      CONSUMER_RATE_ID,
      cea.ADDRESS_ID,
      RESP_ID
    FROM cls_CONSUMERS cc
    LEFT JOIN CE_CONSUMER_RATE cec ON cec.CONSUMER_RATE_ID = cc.consumer_rate_code
    LEFT JOIN CE_ADDRESSES cea ON cea.ADDRESS_CODE = cc.ADDRESS_CODE
    LEFT JOIN ce_RESPONSIBLE cer ON cer.RESP_CODE = cc.RESP_CODE
  MINUS
  SELECT  
    CONSUMER_CODE,
    CONSUMER_TITLE,
    CONSUMER_RATE_ID,
    ADDRESS_ID,
    RESP_ID
  FROM ce_CONSUMERS
  ) cl
ON ( cl.CONSUMER_CODE = ce.CONSUMER_CODE )
WHEN MATCHED
  THEN UPDATE
    SET
      ce.CONSUMER_TITLE = cl.CONSUMER_TITLE,
      ce.CONSUMER_RATE_ID = cl.CONSUMER_RATE_ID,
      ce.ADDRESS_ID = cl.ADDRESS_ID,
      ce.RESP_ID = cl.RESP_ID,
      UPDATE_DT = sysdate
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_consumer.nextval,
      cl.CONSUMER_CODE,
      cl.CONSUMER_TITLE,
      cl.CONSUMER_RATE_ID,
      cl.ADDRESS_ID,
      cl.RESP_ID,
      sysdate,
      sysdate);
COMMIT;
END;

-- CE_PROMOTIONS
PROCEDURE CE_PROMOTIONS AS
BEGIN
MERGE INTO CE_PROMOTIONS ce
  USING (SELECT * FROM cls_promotions) cl
    ON (
      cl.promo_code = ce.promo_code AND
      cl.start_dt = ce.start_dt
      )
  WHEN MATCHED 
    THEN UPDATE 
      SET  
        ce.PROMO_NAME = cl.PROMO_NAME, 
        ce.PROMO_DESC = cl.PROMO_DESC, 
        ce.PROMO_COST = cl.PROMO_COST, 
        ce.END_DT = cl.END_DT
  WHEN NOT MATCHED
    THEN INSERT
      VALUES (
        seq_promotion.nextval,
        cl.PROMO_CODE,
        cl.PROMO_NAME,
        cl.PROMO_DESC,
        cl.PROMO_COST,
        cl.START_DT,
        cl.END_DT,
        cl.IS_ACTIVE,
        sysdate,
        sysdate);
COMMIT;
END;

--==================================================================================================
--==================================================================================================
--==================================================================================================
--==================================================================================================
--==================================================================================================

PROCEDURE CE_SALES AS
BEGIN
-- CLS_SALES
EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_SALES');
INSERT INTO CLS_SALES 
  (
    SALE_DATE,
    DEPARTMENT_CODE,
    CONSUMER_CODE,
    PRODUCT_CODE,
    PROMO_CODE,
    AMOUNT,
    UPDATE_DT,
    INSERT_DT
  )
SELECT
    TO_DATE(TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1980-01-01','J'),TO_CHAR(DATE '2017-12-1','J'))),'J')) AS DATE_ID,
    ROUND(dbms_random.value ( (SELECT MIN(department_id) FROM ce_DEPARTMENTS), (SELECT MAX(department_id) FROM ce_DEPARTMENTS)),0) AS DEPARTMENT_ID,
    ROUND(dbms_random.value ( (SELECT MIN(consumer_id) FROM ce_CONSUMERS), (SELECT MAX(consumer_id) FROM ce_CONSUMERS)),0) AS CONSUMER_ID,
    ROUND(dbms_random.value ( (SELECT MIN(product_id) FROM ce_PRODUCTS), (SELECT MAX(product_id) FROM ce_PRODUCTS)), 0) AS PRODUCT_ID,
    ROUND(dbms_random.value ( (SELECT MIN(promo_id) FROM ce_PROMOTIONS), (SELECT MAX(promo_id) FROM ce_PROMOTIONS)), 0) AS PROMO_ID,
    ABS(ROUND((dbms_random.normal/499+dbms_random.value)*1000,0)) AMOUNT,
    TRUNC(SYSDATE),
    TRUNC(SYSDATE)
  FROM dual
  CONNECT BY level <=1000000;

MERGE INTO  ce_SALES ce
USING ( 
  SELECT * FROM cls_SALES cls
    LEFT JOIN ce_departments d ON cls.department_code = d.department_id
    LEFT JOIN ce_consumers c ON cls.consumer_code = c.consumer_id
    LEFT JOIN ce_products p ON cls.product_code = p.product_id
    LEFT JOIN ce_promotions pc ON cls.promo_code = pc.promo_id
  ) cl
ON ( TRUNC(ce.SALE_DATE) = cl.SALE_DATE AND
      ce.DEPARTMENT_ID = cl.DEPARTMENT_ID AND
      ce.CONSUMER_ID = cl.CONSUMER_ID AND
      ce.PRODUCT_ID = cl.PRODUCT_ID AND
      ce.PROMO_ID = cl.PROMO_ID)
WHEN MATCHED
  THEN UPDATE
    SET
      ce.AMOUNT = cl.AMOUNT,
      ce.update_dt = trunc(sysdate),
      ce.insert_dt = trunc(sysdate)
WHEN NOT MATCHED
  THEN INSERT
    VALUES (
      seq_sale.nextval,
      cl.SALE_DATE,
      cl.DEPARTMENT_ID,
      cl.CONSUMER_ID,
      cl.PRODUCT_ID,
      cl.PROMO_ID,
      cl.amount,
      sysdate,
      sysdate);

  COMMIT;
    END;
END CE_DDL;
/

   
BEGIN
  CE_DDL.CE_PROMOTIONS  ;  
END;