CREATE OR REPLACE PACKAGE BODY pkg_etl_routes
AS
  /**===============================================*\
  Name...............:   pkg_etl_routes
  Contents...........:   Load data of route entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_routes';
  INSERT INTO wrk_routes
  SELECT * FROM ext_routes;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_routes';
  INSERT INTO cls_routes
  SELECT  trim(BOTH '"' from route_code), trim(BOTH '"' from airport_name_from) , trim(BOTH '"' from airport_name_to)
  FROM wrk_routes COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_routes;