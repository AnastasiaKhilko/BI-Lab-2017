CREATE OR REPLACE PACKAGE pkg_etl_load_cl_shop
AS
  PROCEDURE load_cl_shop;
END pkg_etl_load_cl_shop;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_shop
AS
PROCEDURE load_cl_shop
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cl_shop';
  INSERT INTO cl_shop
    ( shop_code, shop_name, phone, email, address_id
    )
  SELECT DISTINCT c.shop_id AS shop_code,
    c.shop_name             AS shop_name,
    c.phone                 AS phone,
    c.email                 AS email,
    ce.address_id           AS address_id
  FROM wrk_shops c
  LEFT JOIN bl_3nf.ce_address ce
  ON c.address = ce.address_name;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_cl_shop;
END pkg_etl_load_cl_shop;
/