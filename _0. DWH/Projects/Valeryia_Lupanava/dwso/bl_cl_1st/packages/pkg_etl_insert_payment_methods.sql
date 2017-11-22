CREATE OR REPLACE PACKAGE pkg_etl_insert_payment_methods
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_payment_methods;
						
END pkg_etl_insert_payment_methods;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_payment_methods
AS
---------------------------------------------------  
PROCEDURE insert_table_payment_methods
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payment_methods');
  INSERT INTO cls_payment_methods (
                                   payment_method,
                                   bank
                                   )
SELECT payment_method_name AS payment_method,
       bank
  FROM wrk_payment_methods;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_payment_methods;
---------------------------------------------------  
END pkg_etl_insert_payment_methods;