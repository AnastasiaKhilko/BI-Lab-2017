CREATE OR REPLACE PACKAGE pkg_etl_load_cl_address
AS
  PROCEDURE load_cl_address;
END pkg_etl_load_cl_address;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_address
AS
PROCEDURE load_cl_address
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cl_address';
  INSERT INTO cl_address
    ( address_name, city_id
    )
  SELECT c.address AS address_name,
    ce.city_id     AS city_id
  FROM wrk_shops c
  LEFT JOIN bl_3nf.ce_city ce
  ON c.city = ce.city_name;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_cl_address;
END pkg_etl_load_cl_address;
/