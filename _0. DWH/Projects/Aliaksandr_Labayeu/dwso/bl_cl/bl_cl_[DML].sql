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

COMMIT;
