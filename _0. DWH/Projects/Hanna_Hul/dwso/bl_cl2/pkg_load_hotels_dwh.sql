CREATE OR REPLACE PACKAGE pkg_load_hotels_dwh
AS
  PROCEDURE load_cls2_hotel;
  PROCEDURE load_dwh;
END pkg_load_hotels_dwh;
/
CREATE OR REPLACE PACKAGE BODY pkg_load_hotels_dwh
AS
PROCEDURE load_cls2_hotel
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_hotels';
  INSERT INTO cls_hotels
  SELECT HOTEL_3NF_ID ,
    HOTEL_CODE ,
    HOTEL_NAME ,
    CATEGORY_ID ,-- references dim_categories(category_id),
    ADDRESS_ID , -- references dim_addresses(address_id),
    EMAIL ,
    UPDATE_DT,
    REVIEWS_DATE,
    REVIEWS_RATING
  FROM bl_3nf.CE_hotels ;
  COMMIT;
  -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
END load_cls2_hotel;
PROCEDURE load_dwh
IS
BEGIN
  MERGE INTO bl_dwh.dwh_hotels d USING
  (SELECT HOTEL_3NF_ID ,
    HOTEL_CODE ,
    HOTEL_NAME ,
    CATEGORY_ID ,-- references dim_categories(category_id),
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
    CATEGORY_ID ,-- references dim_categories(category_id),
    ADDRESS_ID , -- references dim_addresses(address_id),
    EMAIL ,
    UPDATE_DT,
    REVIEWS_DATE,
    REVIEWS_RATING
  FROM bl_dwh.dwh_hotels
  ) cls ON ( cls.hotel_3nf_id = d.hotel_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET d.hotel_code   = cls.hotel_code,
    d.hotel_name     = cls.hotel_name,
    d.category_id    = cls.category_id,
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
      cls.category_id,
      cls.address_id,
      cls.email,
      sysdate,
      cls.reviews_date,
      cls.reviews_rating
    ) ;
  --end;
  COMMIT;
END load_dwh;
END pkg_load_hotels_dwh;
/
SELECT bl_dwh.seq_source_dwh.nextval FROM dual ;
EXEC pkg_load_hotels_dwh.load_cls2_hotel;
EXEC pkg_load_hotels_dwh.load_dwh;