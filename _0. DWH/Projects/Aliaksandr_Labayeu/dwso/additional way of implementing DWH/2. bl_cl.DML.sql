 -- CLS_PRODUCT_CATEGORY
DECLARE
CURSOR cat IS SELECT UNIQUE prod_category_code FROM wrk_products;
c varchar2(20);

BEGIN
  open cat;
  LOOP
    FETCH cat into c;
    exit when cat %notfound;
      EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_PRODUCT_CATEGORY');
      insert into CLS_PRODUCT_CATEGORY (
                      CATEGORY_CODE,
                      CATEGORY_NAME,
                      UPDATE_DT,
                      INSERT_DT
                      )
                SELECT DISTINCT
                      prod_category_code,
                      prod_category,
                      sysdate,
                      sysdate
                FROM wrk_products
                WHERE prod_Category_code IS NOT NULL; 
  END LOOP;
  close cat;
  commit;
END;
/

-- CLS_PRODUCT_SUBCATEGORY
DECLARE
  CURSOR subcat IS SELECT DISTINCT subcategory_code FROM wrk_products;
  sc VARCHAR2(20);
  
  BEGIN
    OPEN subcat;
    LOOP
      FETCH subcat INTO sc;
      EXIT WHEN subcat %notfound;
      EXECUTE IMMEDIATE('TRUNCATE TABLE CLS_PRODUCT_SUBCATEGORY');
      INSERT INTO CLS_PRODUCT_SUBCATEGORY (
        SUBCATEGORY_CODE, 
        SUBCATEGORY_NAME, 
        CATEGORY_CODE,
        "SIZE", 
        TOBACCO, 
        UPDATE_DT, 
        INSERT_DT
      )
      SELECT DISTINCT
        SUBCATEGORY_CODE,
        SUBCATEGORY,
        PROD_CATEGORY_CODE,
        PROD_SIZE,
        TOBACCO,
        sysdate,
        sysdate
      FROM wrk_products
      WHERE subcategory IS NOT NULL;
    END LOOP;
    close subcat;
    commit;
  END;
/

-- CLS_LOCALIZATION
TRUNCATE TABLE cls_localization;
INSERT INTO CLS_LOCALIZATION (
        LOCALIZATION_ID, 
        LOCALIZATION_NAME)
      SELECT 
        seq_localization.nextval,
        localization
        FROM (
        SELECT DISTINCT
          localization
        FROM WRK_PRODUCTS
        WHERE localization IS NOT NULL);

-- CLS_PRODUCTS
DECLARE CURSOR prod IS SELECT DISTINCT(product_code) FROM wrk_products;
p VARCHAR(10);

BEGIN 
  OPEN prod;
  LOOP
    FETCH prod INTO p;
    EXIT WHEN prod%notfound;
    EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_PRODUCTS');
    INSERT INTO CLS_PRODUCTS (
      PRODUCT_CODE, 
      PRODUCT_NAME, 
      LOCALIZATION_CODE, 
      CATEGORY_CODE,
      PRICE,
      UPDATE_DT, 
      INSERT_DT)
    SELECT DISTINCT
      PRODUCT_CODE,
      PRODUCT,
      LOCALIZATION,
      PROD_CATEGORY_CODE,
      prod_price,
      sysdate,
      sysdate
    FROM WRK_PRODUCTS
      WHERE product IS NOT NULL;
  END LOOP;
  close prod;
  commit;
END;
/

-- CLS_OCCUPATION     
TRUNCATE TABLE CLS_OCCUPATION;
INSERT INTO CLS_OCCUPATION (
  OCCUPATION_CODE, 
  OCCUPATION_NAME, 
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  OCCUPATION_CODE,
  OCCUPATION,
  sysdate,
  sysdate
FROM WRK_CONSUMERS;

-- CLS_RESPONSIBLE
---- if there is no name of a customer we remove him as a human who don't wanna be a trustful consumer 
---- and Names with Spaces
TRUNCATE TABLE CLS_RESPONSIBLE;
INSERT INTO CLS_RESPONSIBLE (
  RESP_CODE, 
  FIRST_NAME, 
  LAST_NAME, 
  PHONE, 
  EMAIL, 
  BIRTHDAY, 
  AGE, 
  OCCUPATION_CODE, 
  UPDATE_DT, 
  INSERT_DT
  )
SELECT DISTINCT
  RESPONSIBLE_CODE,
   substr(fullname, instr(fullname, ' ', 1, 2)+1),    
   substr(fullname,instr(fullname,' ',1,1)+1,(instr(fullname,' ',1,2)-instr(fullname,' ',1,1))-1) ,  
  TELEPHONENUMBER, 
  EMAILADDRESS, 
  TO_DATE(BIRTHDAY, 'mm/dd/yyyy'), 
  AGE, 
  OCCUPATION_CODE,
  sysdate,
  sysdate
FROM WRK_CONSUMERS
  WHERE substr(fullname, instr(fullname, ' ', 1, 2)+1,(instr(fullname, ' ', 1, 2)-instr(fullname, ' ', 1, 1))) <> null OR 
    substr(fullname, instr(fullname, ' ', 1, 2)+1,(instr(fullname, ' ', 1, 2)-instr(fullname, ' ', 1, 1))) NOT LIKE '% %';

-- CLS_CONSUMER_RATE
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_CONSUMER_RATE'); 
  FOR CR IN 
      (
        SELECT DISTINCT
          CONSUMER_RATE,
          RATE_DESCRIPTION
        FROM WRK_CONSUMERS
      )
    LOOP
      INSERT INTO CLS_CONSUMER_RATE (
          RATE_ID,
          RATE_TITLE
          )
      VALUES (
          CR.CONSUMER_RATE,
          CR.RATE_DESCRIPTION
          );
  END LOOP;
END;
/

-- CLS_REGIONS
TRUNCATE TABLE CLS_REGIONS;
INSERT INTO CLS_REGIONS (
  REGION_CODE, 
  REGION_NAME,
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  REGION_CODE,
  REGION,
  sysdate,
  sysdate
FROM wrk_locations
WHERE REGION_CODE IS NOT NULL;


-- CLS_SUBREGIONS
TRUNCATE TABLE CLS_SUBREGIONS;
INSERT INTO CLS_SUBREGIONS (
  SUBREGION_CODE, 
  SUBREGION_NAME, 
  REGION_CODE,
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  SUBREGION_CODE,
  SUBREGION,
  r.REGION_CODE,
  sysdate,
  sysdate
FROM WRK_LOCATIONS l
INNER JOIN CLS_REGIONS r ON l.REGION_CODE = r.REGION_CODE
;

-- CLS_COUNTRIES
TRUNCATE TABLE CLS_COUNTRIES;
INSERT INTO CLS_COUNTRIES (
  COUNTRY_CODE2, 
  COUNTRY_CODE3, 
  COUNTRY_NAME,
  SUBREGION_CODE,
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  COUNTRY_CODE2,
  COUNTRY_CODE3,
  COUNTRY_NAME,
  r.SUBREGION_CODE,
  sysdate,
  sysdate
FROM wrk_locations l
INNER JOIN CLS_SUBREGIONS r ON l.SUBREGION_CODE = r.SUBREGION_CODE ;

-- CLS_CITIES
TRUNCATE TABLE CLS_CITIES;
INSERT INTO CLS_CITIES (
  CITY_CODE, 
  CITY_NAME, 
  COUNTRY_CODE,
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  CITY_CODE,
  CITY,
  wc.country_code,
  sysdate,
  sysdate
FROM WRK_CONSUMERS wc
INNER JOIN CLS_COUNTRIES c ON c.COUNTRY_CODE2 = wc.COUNTRY_CODE
WHERE CITY NOT LIKE '%''%';

-- CLS_ADDRESSES
TRUNCATE TABLE CLS_ADDRESSES;
INSERT INTO CLS_ADDRESSES (
  ADDRESS_CODE, 
  ADDRESS, 
  POSTAL_CODE, 
  PHONE, 
  CITY_CODE, 
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  (UPPER(SUBSTR(STREETADDRESS,1,2)) || 
    REPLACE(SUBSTR(STREETADDRESS,LENGTH(STREETADDRESS)-1,1),' ','') || 
    UPPER(LENGTH(ZIPCODE)) ||
    cs1.COUNTRY_CODE || 
    LENGTH(ZIPCODE) ||
    SUBSTR(ZIPCODE,LENGTH(ZIPCODE)-1,1)
  ) AS ADDRESS_CODE,
  STREETADDRESS,
  ZIPCODE,
  TELEPHONENUMBER,
  cs1.CITY_CODE,
  sysdate,
  sysdate
FROM WRK_DEPARTMENTS wd
INNER JOIN CLS_CITIES cs1 ON cs1.CITY_CODE = wd.city_code
  UNION ALL
SELECT DISTINCT
  (UPPER(SUBSTR(STREETADDRESS,1,2)) || 
    REPLACE(SUBSTR(STREETADDRESS,LENGTH(STREETADDRESS)-1,1),' ','') || 
    UPPER(LENGTH(ZIPCODE)) ||
    cs2.COUNTRY_CODE || 
    LENGTH(ZIPCODE) ||
    SUBSTR(ZIPCODE,LENGTH(ZIPCODE)-1,1)
  ) AS ADDRESS_CODE,
  STREETADDRESS,
  ZIPCODE,
  TELEPHONENUMBER,
  cs2.CITY_CODE,
  sysdate,
  sysdate
FROM WRK_CONSUMERS wc
INNER JOIN CLS_CITIES cs2 ON cs2.CITY_CODE = wc.city_code;

-- CLS_DEPARTMENTS
TRUNCATE TABLE CLS_DEPARTMENTS;
INSERT INTO cls_DEPARTMENTS  
(
  DEPARTMENT_CODE, 
  DEPARTMENT_DESC, 
  ADDRESS_CODE,
  START_DT,
  END_DT,
  IS_ACTIVE,
  UPDATE_DT, 
  INSERT_DT )
SELECT DISTINCT
  wrk.DEP_CODE, 
  wrk.DEPARTMENT,
  (UPPER(SUBSTR(wrk.STREETADDRESS,1,2)) || 
    REPLACE(SUBSTR(wrk.STREETADDRESS,LENGTH(wrk.STREETADDRESS)-1,1),' ','') || 
    UPPER(LENGTH(wrk.ZIPCODE)) ||
    wrk.COUNTRY_CODE || 
    LENGTH(wrk.ZIPCODE) ||
    SUBSTR(wrk.ZIPCODE,LENGTH(wrk.ZIPCODE)-1,1)
  )
  AS ADDRESS_CODE,
    NVL2(ce.department_code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt,
    TO_DATE('31/12/9999','DD/MM/YYYY') end_dt,
    'Y',
  sysdate,
  sysdate
FROM wrk_departments wrk
LEFT JOIN ce_departments ce 
  ON (
    ce.department_code = wrk.dep_code AND
    ce.END_DT > TRUNC(SYSDATE) AND
    ce.START_DT <= TRUNC(SYSDATE)
  )
LEFT JOIN ce_addresses cea ON cea.address_code =   (UPPER(SUBSTR(wrk.STREETADDRESS,1,2)) || 
                                                      REPLACE(SUBSTR(wrk.STREETADDRESS,LENGTH(wrk.STREETADDRESS)-1,1),' ','') || 
                                                      UPPER(LENGTH(wrk.ZIPCODE)) ||
                                                      wrk.COUNTRY_CODE || 
                                                      LENGTH(wrk.ZIPCODE) ||
                                                      SUBSTR(wrk.ZIPCODE,LENGTH(wrk.ZIPCODE)-1,1)
                                                    )
WHERE DECODE(wrk.department, ce.department_desc, 0,1)>0;


-- CLS_CONSUMERS
-- same consumer can have different locaitons
TRUNCATE TABLE CLS_CONSUMERS;
INSERT /* + PARALLEL(8) */
INTO CLS_CONSUMERS (
  CONSUMER_CODE, 
  CONSUMER_TITLE, 
  CONSUMER_RATE_CODE, 
  ADDRESS_CODE, 
  RESP_CODE, 
  UPDATE_DT, 
  INSERT_DT)
SELECT DISTINCT
  CONSUMER_CODE,
  COMPANY,
    RATE_ID,
    (UPPER(SUBSTR(wc.STREETADDRESS,1,2)) || 
        REPLACE(SUBSTR(wc.STREETADDRESS,LENGTH(wc.STREETADDRESS)-1,1),' ','') || 
        UPPER(LENGTH(wc.ZIPCODE)) ||
        wc.COUNTRY_CODE || 
        LENGTH(wc.ZIPCODE) ||
        SUBSTR(wc.ZIPCODE,LENGTH(wc.ZIPCODE)-1,1)
      ) AS ADDRESS_CODE,
    RESP_CODE,
  sysdate,
  sysdate
FROM wrk_consumers wc
LEFT JOIN CLS_CONSUMER_RATE ccr ON ccr.rate_id = wc.consumer_rate
LEFT JOIN CLS_RESPONSIBLE cr ON cr.resp_code = wc.responsible_code
WHERE COMPANY IS NOT NULL;

-- CLS_PROMOTIONS
-- same promotions can be in the 
TRUNCATE TABLE CLS_PROMOTIONS;
INSERT INTO cls_PROMOTIONS 
SELECT 
  wrk.promo_code, 
  wrk.promo_name, 
  wrk.promo_desc, 
  wrk.promo_cost, 
  NVL2(ce.promo_code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt,
  TO_DATE('31/12/9999','DD/MM/YYYY') end_dt,
  'Y'
FROM wrk_PROMOTIONS wrk
LEFT JOIN ce_promotions ce 
  ON ( 
    ce.promo_code = wrk.promo_code AND
    ce.END_DT > TRUNC(SYSDATE) AND
    ce.START_DT <= TRUNC(SYSDATE)
    )
WHERE DECODE(wrk.promo_name, ce.promo_name, 0,1)>0
  UNION ALL
SELECT 
  ce.promo_code, 
  ce.promo_name, 
  ce.promo_desc, 
  ce.promo_cost, 
  start_dt,
  TRUNC(SYSDATE) end_dt,
  ce.IS_ACTIVE
FROM wrk_promotions wrk
LEFT JOIN ce_promotions ce
  ON (
    ce.promo_code = wrk.promo_code AND
    ce.END_DT > TRUNC(SYSDATE) AND
    ce.START_DT <= TRUNC(SYSDATE)
  )
WHERE DECODE(wrk.promo_name, ce.promo_name, 0,1)>1;



--==========================================================
--== 3 NF ==================================================
--==========================================================

-- CE_REGIONS
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

-- CE_SUBREGIONS
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

 -- CE_COUNTRIES
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

-- CE_CITIES
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

-- CE_ADDRESSES
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



-- CE_DEPARTMENTS
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

-- CE_PRODUCT_SUBCATEGORY
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

-- CE_LOCALIZATION
TRUNCATE TABLE bl_3nf.ce_localization; -- TRUNC
INSERT INTO ce_localization SELECT * FROM cls_localization;

-- CE_PRODUCTS
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

-- CE_CONSUMER_RATE
TRUNCATE TABLE "BL_3NF"."CE_CONSUMER_RATE"; -- TRUNC
INSERT INTO ce_consumer_rate SELECT * FROM cls_consumer_rate;
-- SELECT * FROM ce_consumer_rate;

-- CE_OCCUPATION
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

-- CE_RESPONSIBLE
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

-- CE_CONSUMERS
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

-- CE_PROMOTIONS
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


--==================================================================================================
--==================================================================================================
--==================================================================================================
--==================================================================================================
--==================================================================================================

-- CLS_SALES
TRUNCATE TABLE CLS_SALES;
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