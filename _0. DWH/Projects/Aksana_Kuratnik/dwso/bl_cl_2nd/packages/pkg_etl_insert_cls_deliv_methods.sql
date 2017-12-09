CREATE OR REPLACE PACKAGE pkg_etl_insert_deliv_methods
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_deliv_methods;				
END pkg_etl_insert_deliv_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_deliv_methods
AS 
PROCEDURE insert_cls_deliv_methods
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_delivery_methods');
INSERT INTO cls_delivery_methods
SELECT DISTINCT
    delivery_method_id AS delivery_method_surr_id,
    delivery_method_srcid AS delivery_method_id,
    delivery_method_desc AS delivery_method_name,
    start_dt,
    end_dt,
    is_active
FROM   bl_3nf.ce_delivery_methods;
  COMMIT; 
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_cls_deliv_methods;
END pkg_etl_insert_deliv_methods;