INSERT INTO wrk_locations
  SELECT * FROM sa_src.ext_locations;
  COMMIT;

INSERT INTO CLS_REGIONS (
  REGION_CODE, 
  REGION_NAME)
SELECT DISTINCT
  REGION_CODE,
  REGION
FROM wrk_locations
WHERE REGION_CODE IS NOT NULL;

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
select * from cls_subregions;
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
  --CITY_CODE,
  STATE,
  CITY,
  wc.country
FROM WRK_CUSTOMERS wc
INNER JOIN CLS_COUNTRIES c ON c.COUNTRY_CODE2 = wc.COUNTRY;

--merge into CLS_CITIES USING(
--)
COMMIT;

TRUNCATE TABLE CLS_addresseS;
INSERT INTO CLS_addresseS (
  --CITY_CODE, 

  --address_id ,
address ,
city_id  ,--references dim_cities (city_id),
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
left JOIN bl_3nf.ce_CITIES c ON c.City_name = wc.City;

CREATE OR REPLACE TRIGGER dept_bir 
BEFORE INSERT ON cls_addresses 
FOR EACH ROW

BEGIN
  SELECT dept_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/
insert into cls_addresses (select distinct
address ,
city_id  ,--references dim_cities (city_id),
postal_code,
sysdate
from cls_addresses-- ad left join bl_3nf.ce_cities c  on ad.city_id = c.city_3nf_id
minus
select address,
city_3nf_id,
postalCode,
sysdate from
(select distinct
address,
city,
postalCode,
sysdate
from   wrk_hotels) h left join bl_3nf.ce_cities c  on h.city= c.city_name
);
SELECT DISTINCT
  --CITY_CODE,
   Address,
   
   
  c.city_3nf_id,
  postalcode,
  sysdate
FROM bl_3nf.ce_addresses h
left JOIN bl_3nf.ce_CITIES c ON c.City_name = h.City
;--??
COMMIT;
insert into bl_3nf.ce_addresses(
address_id,
address,
city_id ,--references dim_cities (city_id),
postal_code,
--phone varchar2(10),
update_dt) select 
seq_addresses_3nf.nextval,
address ,
city_id  ,--references dim_cities (city_id),
postal_code ,
update_dt
from cls_addresses;

TRUNCATE TABLE CLS_CITIES;
INSERT INTO bl_3nf.CE_CITIES 
SELECT seq_cities_3nf.nextval, 
CITY_CODE, 
  CITY_NAME, 
  COUNTRY_CODE
FROM cls_cities;
select * from cls_cities;
select * from bl_3nf.CE_REGIONS ;
commit;
select * from BL_3NF.CE_SUBREGIONS ;
select * from bl_3nf.CE_COUNTRIES ;
select * from bl_3nf.CE_CITIES ;
select * from bl_3nf.ce_addresses;
DROP SEQUENCE seq_addresses_3nf;
CREATE SEQUENCE seq_addresses_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
select * from bl_3nf.ce_cities;
DROP SEQUENCE seq_cities_3nf;
CREATE SEQUENCE seq_cities_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
