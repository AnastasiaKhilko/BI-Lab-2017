CREATE OR REPLACE PACKAGE pkg_etl_load_cl_seller
AS
  PROCEDURE load_cl_seller;
END pkg_etl_load_cl_seller;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_seller
AS
PROCEDURE load_cl_seller
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cl_seller';
  INSERT INTO cl_seller
    ( seller_code, name, surname, phone, email, city_id
    )
  SELECT DISTINCT seller_id AS seller_code,
    c.name                  AS name,
    c.surname               AS surname,
    c.phone                 AS phone,
    c.email                 AS email,
    ce.city_id              AS city_id
  FROM wrk_seller c
  LEFT JOIN bl_3nf.ce_city ce
  ON c.city = ce.city_name;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_cl_seller;
END pkg_etl_load_cl_seller;
/