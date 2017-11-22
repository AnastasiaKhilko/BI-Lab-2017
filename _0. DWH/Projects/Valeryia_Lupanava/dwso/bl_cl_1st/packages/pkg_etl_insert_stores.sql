CREATE OR REPLACE PACKAGE pkg_etl_insert_stores
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_stores;
						
END pkg_etl_insert_stores;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_stores
AS
---------------------------------------------------  
PROCEDURE insert_table_stores
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_stores');
  INSERT INTO cls_stores (
                              store_id,
                              store_name,
                              manager_id,
                              phone,
                              address,
                              city_id
                            )
  SELECT store_code AS store_id,
         store_name,
         manager_id,
         phone,
         address,
         wct.city_id
  FROM   wrk_stores wst left join wrk_cities wct on wst.city = wct.city_desc;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_stores;
---------------------------------------------------  
END pkg_etl_insert_stores;