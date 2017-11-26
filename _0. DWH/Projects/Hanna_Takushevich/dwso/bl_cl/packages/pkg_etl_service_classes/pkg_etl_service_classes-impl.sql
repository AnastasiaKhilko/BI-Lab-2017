CREATE OR REPLACE PACKAGE BODY pkg_etl_service_classes
AS
  /**===============================================*\
  Name...............:   pkg_etl_service_classes
  Contents...........:   Load data of service class entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_service_classes';
  INSERT INTO wrk_service_classes
  SELECT * FROM ext_service_classes;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_service_classes';
  INSERT INTO cls_service_classes
  SELECT class_name,
    seat_letter,
    menu,
    to_number(max_luggage),
    class_desc
  FROM wrk_service_classes COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_service_classes;