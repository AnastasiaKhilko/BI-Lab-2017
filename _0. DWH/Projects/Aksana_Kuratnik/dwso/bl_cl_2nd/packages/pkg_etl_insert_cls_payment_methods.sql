CREATE OR REPLACE PACKAGE pkg_etl_insert_payment_methods
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_payment_methods;				
END pkg_etl_insert_payment_methods;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment_methods
AS 
PROCEDURE insert_cls_payment_methods
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payment_methods');
INSERT INTO cls_payment_methods
SELECT DISTINCT
    payment_method_id AS payment_method_surr_id,
    payment_method_srcid AS payment_method_id,
    payment_method_desc AS payment_method_name,
    start_dt,
    end_dt,
    is_active
FROM   bl_3nf.ce_payment_methods;
  COMMIT; 
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_cls_payment_methods;
END pkg_etl_insert_payment_methods;