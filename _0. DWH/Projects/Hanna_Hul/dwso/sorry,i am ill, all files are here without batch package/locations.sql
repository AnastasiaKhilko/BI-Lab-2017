CREATE OR REPLACE PROCEDURE load_locations
AS
BEGIN
  INSERT INTO wrk_locations
  SELECT * FROM sa_src.ext_locations;
  COMMIT;
  EXECUTE immediate 'TRUNCATE TABLE CLS_REGIONS';
  INSERT INTO CLS_REGIONS
    ( REGION_CODE, REGION_NAME
    )
  SELECT DISTINCT REGION_CODE,
    REGION
  FROM wrk_locations
  WHERE REGION_CODE IS NOT NULL;
  COMMIT;
  merge INTO bl_3nf.CE_REGIONS ce USING
  (SELECT REGION_CODE, REGION_NAME FROM cls_regions
  MINUS
  SELECT REGION_CODE, REGION_NAME FROM bl_3nf.CE_REGIONS
  ) cls ON(cls.region_code = ce.region_code)
WHEN MATCHED THEN
  UPDATE SET ce.REGION_name = cls.REGION_name WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.seq_regions_3nf.nextval,
      cls.REGION_CODE,
      cls.REGION_name
    ) ;
  --SELECT * FROM bl_3nf.CE_REGIONS;
  COMMIT;------------------------------------------
  EXECUTE immediate 'TRUNCATE TABLE CLS_SUBREGIONS';
  INSERT INTO CLS_SUBREGIONS
    ( SUBREGION_CODE, SUBREGION_NAME, REGION_CODE
    )
  SELECT DISTINCT SUBREGION_CODE,
    SUBREGION,
    r.REGION_CODE
  FROM WRK_LOCATIONS l
  INNER JOIN CLS_REGIONS r
  ON l.REGION_CODE = r.REGION_CODE ;
  COMMIT;
  --SELECT * FROM cls_subregions;
  merge INTO bl_3nf.CE_subREGIONS ce USING
  (SELECT subREGION_CODE,
    subREGION_NAME ,
    REGION_3nf_id
  FROM cls_subregions s
  LEFT JOIN bl_3nf.ce_regions r
  ON s.region_code = r.region_code
  MINUS
  SELECT subREGION_CODE, subREGION_NAME , REGION_ID FROM bl_3nf.CE_subREGIONS
  ) cls ON(cls.subregion_code = ce.subregion_code)
WHEN MATCHED THEN
  UPDATE
  SET ce.subREGION_name = cls.subREGION_name,
    ce.REGION_id        = cls.REGION_3nf_id WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.seq_subregions_3nf.nextval,
      cls.subREGION_CODE,
      cls.subREGION_name,
      cls.REGION_3nf_id
    ) ;
  COMMIT;
  -----------------------------------------------------
  EXECUTE immediate 'TRUNCATE TABLE cls_countries';
  INSERT
  INTO cls_COUNTRIES
    (
      COUNTRY_CODE2,
      COUNTRY_CODE3,
      COUNTRY_NAME,
      SUBREGION_CODE
    )
  SELECT DISTINCT COUNTRY_CODE2,
    COUNTRY_CODE3,
    upper(COUNTRY_NAME),
    r.SUBREGION_CODE
  FROM wrk_locations l
  INNER JOIN cls_SUBREGIONS r
  ON l.SUBREGION_CODE = r.SUBREGION_CODE ;
  COMMIT;
  merge INTO bl_3nf.CE_countries ce USING
  (SELECT COUNTRY_CODE2 ,
    COUNTRY_CODE3,
    COUNTRY_NAME,
    SUBREGION_3nf_ID AS subregion_id
  FROM cls_countries cl
  LEFT JOIN bl_3nf.ce_subregions r
  ON cl.subregion_code = r.subregion_code
  MINUS
  SELECT COUNTRY_CODE2 ,
    COUNTRY_CODE3,
    COUNTRY_NAME,
    SUBREGION_ID
  FROM bl_3nf.CE_countries
  ) cls ON(cls.country_code3 = ce.country_code3 AND cls.country_code2 = ce.country_code2)
WHEN MATCHED THEN
  UPDATE
  SET ce.country_name = cls.country_name,
    ce.subREGION_id   = cls.subREGION_id WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.seq_countries_3nf.nextval,
      cls.COUNTRY_CODE2 ,
      cls.COUNTRY_CODE3,
      cls.COUNTRY_NAME,
      cls.SUBREGION_id
    ) ;
  COMMIT;
  --SELECT * FROM cls_countries;
  ------------------------------------------
  EXECUTE immediate 'TRUNCATE TABLE CLS_CITIES';
  INSERT INTO CLS_CITIES
    (
      --CITY_CODE,
      CITY_NAME, COUNTRY_CODE
    )
  SELECT DISTINCT
    --CITY_CODE,
    --STATE,
    upper(CITY),
    wc.country
  FROM WRK_CUSTOMERS wc
  INNER JOIN CLS_COUNTRIES c
  ON c.COUNTRY_CODE2 = wc.COUNTRY
  UNION
  SELECT DISTINCT
    --CITY_CODE,
    --STATE,
    upper(CITY),
    h.country
  FROM WRK_HOtels h
  INNER JOIN CLS_COUNTRIES co
  ON co.COUNTRY_CODE2 = h.COUNTRY ;
  --select * from cls_cities where city_code is not null;
  merge INTO bl_3nf.CE_cities ce USING
  (SELECT CITY_NAME,
    COUNTRY_3nf_ID AS country_id
  FROM cls_cities cl
  LEFT JOIN bl_3nf.CE_COUNTRIES c
  ON c.COUNTRY_CODE2 = cl.COUNTRY_Code
  MINUS
  SELECT CITY_NAME, COUNTRY_ID FROM bl_3nf.CE_cities
  ) cls ON(cls.city_name = ce.city_name AND cls.COUNTRY_ID = ce.COUNTRY_ID)
  --WHEN MATCHED THEN UPDATE
  --set
  --ce.country_name = cls.country_name,
  --ce.subREGION_code = cls.subREGION_code
WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_3nf.seq_cities_3nf.nextval,
      cls.City_name ,
      cls.COUNTRY_ID
    );
  COMMIT;
  --SELECT * FROM cls_cities;
  -------------------------------------------------------------
 -- SELECT *
  --FROM CLS_addresseS;
  execute immediate 'TRUNCATE TABLE CLS_addresseS';
  INSERT
  INTO CLS_addresseS
    (
      --CITY_CODE,
      --address_id ,
      address ,
      city_id ,--references dim_cities (city_id),
      postal_code ,
      update_dt
      --phone varchar2(10),
    )
  SELECT DISTINCT
    --CITY_CODE,
    StreetAddress,
    c.city_3nf_id,
    zipcode,
    sysdate
  FROM WRK_CUSTOMERS wc
  LEFT JOIN bl_3nf.ce_CITIES c
  ON c.City_name = upper(wc.City)
  LEFT JOIN bl_3nf.ce_COUNTRIES cc
  ON wc.country = cc.country_code2
  UNION
  SELECT DISTINCT
    --CITY_CODE,
    Address,
    ci.city_3nf_id,
    postalcode,
    sysdate
  FROM WRK_hotels h
  LEFT JOIN bl_3nf.ce_CITIES ci
  ON ci.City_name = upper(h.City)
  LEFT JOIN bl_3nf.ce_COUNTRIES cc
  ON h.country = cc.country_code2;
   merge INTO bl_3nf.CE_addresses ce USING
  (SELECT /*--ADDRESS_ID,*/
    ADDRESS , CITY_ID, POSTAL_CODE FROM cls_addresses-- cl --left join bl_3nf.CE_Cities c
  --ON c.COUNTRY_CODE2 = cl.COUNTRY_Code
  MINUS
  SELECT ADDRESS , CITY_ID, POSTAL_CODE FROM bl_3nf.CE_addresses
  ) cls ON(cls.city_id = ce.city_id AND cls.address = ce.address)
WHEN MATCHED THEN
  UPDATE
  SET ce.postal_code = cls.postal_code
    --ce.subREGION_code = cls.subREGION_code
    WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      seq_addresses_3nf.nextval,
      cls.address,
      cls.City_id ,
      cls.postal_code,
      sysdate
    );
  COMMIT;
  SELECT * FROM cls_addresses;
  ----------------------------------------------------------------------------------------------------
  END load_locations;
------------------------------------------