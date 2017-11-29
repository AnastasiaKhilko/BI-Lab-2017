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
        CATEGORY_CODE, -- !!!
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

-- SELECT * FROM CLS_PRODUCT_CATEGORY;
-- SELECT * FROM CLS_PRODUCT_SUBCATEGORY;

-- CLS_LOCALIZATION
DECLARE 
  CURSOR localiz IS SELECT DISTINCT(localization) FROM WRK_PRODUCTS;
  l VARCHAR2(10);
  
  BEGIN
    OPEN localiz;
    LOOP
      FETCH localiz INTO l; 
      EXIT WHEN localiz%notfound;
      EXECUTE IMMEDIATE ('TRUNCATE TABLE CLS_LOCALIZATION');
      INSERT INTO CLS_LOCALIZATION (
        LOCALIZATION_ID, 
        LOCALIZATION_NAME)
      SELECT 
        seq_localization.nextval,
        localization
        FROM (
        SELECT DISTINCT
          localization
        FROM WRK_PRODUCTS)
      WHERE localization IS NOT NULL;
    END LOOP;
  close localiz;
  commit;
END;
/

-- SELECT * FROM CLS_LOCALIZATION;

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
      START_DT, 
      END_DT, 
      IS_ACTIVE, 
      UPDATE_DT, 
      INSERT_DT)
    SELECT DISTINCT
      PRODUCT_CODE,
      PRODUCT,
      LOCALIZATION,
      PROD_CATEGORY_CODE,
      sysdate,
      '31-DEC-9999',
      'Y',
      sysdate,
      sysdate
    FROM WRK_PRODUCTS;
  END LOOP;
  close prod;
  commit;
END;
/
  
-- SELECT * FROM cls_products;

-- CLS_OCCUPATION
DECLARE CURSOR occup IS SELECT DISTINCT OCCUPATION FROM WRK_CONSUMERS;
oc VARCHAR2(20);

BEGIN
  OPEN occup;
  LOOP 
    FETCH occup INTO oc;
    EXIT WHEN occup%notfound;
      EXECUTE IMMEDIATE('TRUNCATE TABLE CLS_OCCUPATION');
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
  END LOOP;
  CLOSE occup;
  commit;
END;
/
-- ===================================== BULK COLLECT!
-- SELECT * FROM CLS_OCCUPATION;
--- SELECT COUNT( DISTINCT occupation_code) FROM wrk_consumers;
--- SELECT COUNT ( DISTINCT consumer_code) FROM wrk_consumers;

-- CLS_RESPONSIBLE
DECLARE CURSOR resp IS SELECT DISTINCT FULLNAME FROM WRK_CONSUMERS;
rp VARCHAR2(30);

BEGIN
  OPEN resp;
  LOOP 
    FETCH resp INTO rp;
    EXIT WHEN resp%notfound;
      EXECUTE IMMEDIATE('TRUNCATE TABLE CLS_RESPONSIBLE');
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
         substr(fullname, instr(fullname, ' ', 1, 2)+1,(instr(fullname, ' ', 1, 2)-instr(fullname, ' ', 1, 1))),
         substr(fullname, instr(fullname, ' ', 1, 2)+1),    
        TELEPHONENUMBER, 
        EMAILADDRESS, 
        TO_DATE(BIRTHDAY, 'mm/dd/yyyy'), 
        AGE, 
        OCCUPATION_CODE,
        sysdate,
        sysdate
      FROM WRK_CONSUMERS;
  END LOOP;
  CLOSE resp;
  commit;
END;
/
-- ===================================== BULK COLLECT!   
-- SELECT TO_DATE(BIRTHDAY, 'mm/dd/yyyy') FROM wrk_consumers ;
-- SELECT * FROM wrk_consumers;
-- SELECT COUNT(company) FROM wrk_consumers;

-- CLS_CONSUMER_RATE
TRUNCATE TABLE CLS_CONSUMER_RATE;
INSERT INTO CLS_CONSUMER_RATE (
  CONSUMER_RATE_ID, 
  RATE_TITLE
  )
  SELECT DISTINCT
    CONSUMER_RATE,
    RATE_DESCRIPTION
    FROM WRK_CONSUMERS
;

---------------------------------------
TRUNCATE TABLE CLS_REGIONS;
INSERT INTO CLS_REGIONS (
  REGION_CODE, 
  REGION_NAME)
SELECT DISTINCT
  REGION_CODE,
  REGION
FROM wrk_locations
WHERE REGION_CODE IS NOT NULL;
-- SELECT * FROM regions;

TRUNCATE TABLE CLS_SUBREGIONS;
INSERT INTO CLS_SUBREGIONS (
  SUBREGION_CODE, 
  SUBREGION_NAME, 
  REGION_CODE)
SELECT DISTINCT
  SUBREGION_CODE,
  SUBREGION,
  r.REGION_CODE
FROM WRK_LOCATIONS l
INNER JOIN CLS_REGIONS r ON l.REGION_CODE = r.REGION_CODE
;

TRUNCATE TABLE CLS_COUNTRIES;
INSERT INTO CLS_COUNTRIES (
  COUNTRY_CODE2, 
  COUNTRY_CODE3, 
  COUNTRY_NAME,
  SUBREGION_CODE)
SELECT DISTINCT
  COUNTRY_CODE2,
  COUNTRY_CODE3,
  COUNTRY_NAME,
  r.SUBREGION_CODE
FROM wrk_locations l
INNER JOIN CLS_SUBREGIONS r ON l.SUBREGION_CODE = r.SUBREGION_CODE ;
SELECT * FROM wrk_locations;
-- SELECT * FROM COUNTRIES;

TRUNCATE TABLE CLS_CITIES;
INSERT INTO CLS_CITIES (
  CITY_CODE, 
  CITY_NAME, 
  COUNTRY_CODE)
SELECT DISTINCT
  CITY_CODE,
  CITY,
  wc.country_code
FROM WRK_CONSUMERS wc
INNER JOIN CLS_COUNTRIES c ON c.COUNTRY_CODE2 = wc.COUNTRY_CODE;

-- SELECT * FROM WRK_CONSUMERS;
-- SELECT * FROM WRK_LOCATIONS;
-- SELECT * FROM cities;

SELECT * FROM WRK_LOCATIONS wl
LEFT JOIN WRK_CONSUMERS wc ON wl.COUNTRY_CODE2 = COUNTRY_CODE;
--==========================================================
--== 3 ce ==================================================
--==========================================================

MERGE INTO ce_PRODUCT_CATEGORY ce
USING (
  SELECT category_code, category_name, insert_dt, update_dt FROM CLS_PRODUCT_CATEGORY 
  MINUS 
  SELECT category_code, category_name, insert_dt, update_dt FROM ce_PRODUCT_CATEGORY
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
        cl.UPDATE_DT, 
        cl.INSERT_DT
        );

-- SELECT * FROM ce_PRODUCT_CATEGORY;
MERGE INTO ce_PRODUCT_SUBCATEGORY ce
USING (
      SELECT
            cls.SUBCATEGORY_CODE,
            cls.SUBCATEGORY_NAME, 
            ce_c.category_id,
            cls."SIZE",
            cls.tobacco,
            cls.UPDATE_DT, 
            cls.INSERT_DT
          FROM CLS_PRODUCT_SUBCATEGORY cls 
          LEFT JOIN ce_PRODUCT_CATEGORY ce_c
          ON cls.category_code = ce_c.category_code
  MINUS
        SELECT
            ce.SUBCATEGORY_CODE,
            ce.SUBCATEGORY_NAME, 
            ce.category_id,
            ce."SIZE",
            ce.tobacco,
            ce.UPDATE_DT, 
            ce.INSERT_DT
          FROM ce_PRODUCT_SUBCATEGORY ce 
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
        cl.UPDATE_DT, 
        cl.INSERT_DT
        );

-- SELECT * FROM ce_PRODUCT_SUBCATEGORY;

