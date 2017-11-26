CREATE OR REPLACE PACKAGE BODY pkg_etl_payments
AS
  /**===============================================*\
  Name...............:   pkg_etl_payments
  Contents...........:   Load data of payment entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_payments';
  INSERT INTO wrk_payments
  SELECT * FROM ext_payments;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_payments';
  INSERT INTO cls_payments
  SELECT trim(both '"'
  FROM payment_code),
    trim(both '"'
  FROM service_class_name),
    trim(both '"'
  FROM route_code),
    to_number(SUBSTR(price,1, instr(price, chr(13))-2))
  FROM wrk_payments COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_payments;