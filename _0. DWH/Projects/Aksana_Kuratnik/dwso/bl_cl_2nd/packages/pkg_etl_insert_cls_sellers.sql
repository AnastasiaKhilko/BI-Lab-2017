CREATE OR REPLACE PACKAGE pkg_etl_insert_sellers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_sellers;
END pkg_etl_insert_sellers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_sellers
AS
PROCEDURE insert_cls_sellers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_sellers');
  INSERT INTO cls_sellers
SELECT DISTINCT
      seller_id AS seller_surr_id,
      seller_srcid AS seller_id,
      first_name,
      last_name,
      age,
      email,
      phone,
      address,
      start_dt,
      end_dt,
      is_active
FROM  bl_3nf.ce_sellers 
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_cls_sellers;
END pkg_etl_insert_sellers;
/