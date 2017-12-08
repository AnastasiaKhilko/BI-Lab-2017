CREATE OR REPLACE PACKAGE pkg_etl_load_hotels
AS
  PROCEDURE load_hotels;
  PROCEDURE load_hotels_cls;
  PROCEDURE load_ce;
END pkg_etl_load_hotels;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_hotels
AS
PROCEDURE load_hotels
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_hotels';
  INSERT INTO wrk_hotels
  SELECT * FROM sa_src.ext_hotels;
  COMMIT;
END load_hotels;

PROCEDURE load_hotels_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_hotels';
  INSERT INTO cls_hotels
  select distinct
       ' 2',-- hotel_code,
         
         2,--address_id,
         --categories VARCHAR2 ( 200),
        -- 1,--category_id,
        round( abs(dbms_random.normal*2)+0.59),
        -- city VARCHAR2 ( 200  ),
        -- country	 VARCHAR2 ( 200  ),
        -- latitude VARCHAR2 ( 200  ),
        -- longitude VARCHAR2 ( 200  ),
         name_,
          Replace(UPPER(SUBSTR(NAME_,1,1)) || LOWER(SUBSTR(NAME_,2,29) || '@gmail.com'),' ',''),

       -- sysdate,
         --postalCode VARCHAR2 ( 200 ),
        -- province VARCHAR2 ( 200  ),
         to_char(max(reviews_date)),
         to_char(max(reviews_rating))
   from wrk_hotels group by name_;-- h 
   --left join bl_3nf.ce_cities cc on upper(cc.city_name) = upper(h.city)
  -- left join bl_3nf.ce_addresses a on a.city_id = cc.city_id and a.postal_code = h.postalcode   ;
  COMMIT;
END load_hotels_cls;

PROCEDURE load_ce
       IS
       begin
MERGE INTO bl_3nf.ce_hotels ce USING
( SELECT   hotel_code,
name,
category_id,
         address_id,
         --categories VARCHAR2 ( 200),
         
        -- city VARCHAR2 ( 200  ),
        -- country	 VARCHAR2 ( 200  ),
        -- latitude VARCHAR2 ( 200  ),
        -- longitude VARCHAR2 ( 200  ),
        email,--????????
       -- update_date,--????????
         
         --postalCode VARCHAR2 ( 200 ),
        -- province VARCHAR2 ( 200  ),
        reviews_date,
         reviews_rating
         FROM cls_hotels
MINUS
SELECT  --hotel_3nf_id number primary key,
hotel_code,
hotel_name,
category_id,
address_id,
email,
--update_dt,
reviews_date,
reviews_rating
         FROM bl_3nf.ce_hotels
 )
 cls 
ON ( cls.name = ce.hotel_name )
WHEN MATCHED THEN
  UPDATE
  SET 
      ce.hotel_code = cls.hotel_code,
ce.category_id = cls.category_id,
ce.address_id = cls.address_id,
ce.email = cls.email,
ce.update_dt=sysdate,
ce.reviews_date = cls.reviews_date,
ce.reviews_rating = cls.reviews_rating
    WHEN NOT MATCHED THEN
  INSERT
    (
    hotel_3nf_id,
    hotel_code,
hotel_name,
category_id,
address_id,
email,
update_dt,
reviews_date,
reviews_rating
    )
    VALUES
    (
         seq_hotels_3nf.nextval ,
          cls.hotel_code,
          
cls.name,
cls.category_id,
cls.address_id,
cls.email,
sysdate,
cls.reviews_date,
cls.reviews_rating
    ) ;
    --end;
   commit;
    end load_ce;
END pkg_etl_load_hotels;
/
EXECUTE pkg_etl_load_hotels.load_hotels;
EXECUTE pkg_etl_load_hotels.load_hotels_cls;
EXECUTE pkg_etl_load_hotels.load_ce;
--PROCEDURE generate_source;
--Procedure load_hotels;
DROP SEQUENCE seq_hotels_3nf;
CREATE SEQUENCE seq_hotels_3nf INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
SELECT *
FROM wrk_hotels;
SELECT *
FROM cls_hotels;
SELECT *
FROM bl_3nf.ce_hotels;