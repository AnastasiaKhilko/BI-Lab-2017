CREATE OR REPLACE PACKAGE pkg_load_dwh_hotels
AS
  PROCEDURE load_cls2_hotel;
  PROCEDURE load_dwh;
END pkg_load_dwh_hotels;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_dwh_hotels
AS
PROCEDURE load_cls2_hotel
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_hotels';
  INSERT INTO cls_hotels
  SELECT HOTEL_3NF_ID ,
    HOTEL_CODE ,
    HOTEL_NAME ,
    CATEGORY_NAME ,-- references dim_categories(category_id),
    START_DT,
    END_DT ,
    IS_ACTIVE ,
    ADDRESS_ID , 
    EMAIL ,
    h.UPDATE_DT,
    REVIEWS_DATE,
    REVIEWS_RATING
  FROM bl_3nf.CE_hotels h left join bl_3nf.ce_categories ce
  on h.category_id = ce.category_3nf_id;
  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
END load_cls2_hotel;
PROCEDURE load_dwh
IS
BEGIN
  MERGE INTO bl_dwh.dim_hotels d USING
  (SELECT HOTEL_3NF_ID ,
    HOTEL_CODE ,
    HOTEL_NAME ,
    CATEGORY_NAME ,-- references dim_categories(category_id),
    ADDRESS_ID , -- references dim_addresses(address_id),
    EMAIL ,
    UPDATE_DT,
    REVIEWS_DATE,
    REVIEWS_RATING
  FROM cls_hotels
  MINUS
  SELECT HOTEL_3NF_ID ,
    HOTEL_CODE ,
    HOTEL_NAME ,
    CATEGORY_NAME ,-- references dim_categories(category_id),
    ADDRESS_ID , -- references dim_addresses(address_id),
    EMAIL ,
    UPDATE_DT,
    REVIEWS_DATE,
    REVIEWS_RATING
  FROM bl_dwh.dim_hotels
  ) cls ON ( cls.hotel_3nf_id = d.hotel_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET d.hotel_code   = cls.hotel_code,
    d.hotel_name     = cls.hotel_name,
    d.category_name    = cls.category_name,
    d.address_id     = cls.address_id,
    d.email          = cls.email,
    d.update_dt      =sysdate,
    d.reviews_date   = cls.reviews_date,
    d.reviews_rating = cls.reviews_rating WHEN NOT MATCHED THEN
  INSERT VALUES
    (
      bl_dwh.seq_hotels_dwh.nextval ,
      cls.hotel_3nf_id ,
      cls.hotel_code,
      cls.hotel_name,
      cls.category_name,
      cls.address_id,
      cls.email,
      sysdate,
      cls.reviews_date,
      cls.reviews_rating
    ) ;
  --end;
  COMMIT;
END load_dwh;
END pkg_load_dwh_hotels;
/
