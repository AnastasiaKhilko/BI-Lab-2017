CREATE OR REPLACE PACKAGE BODY pkg_etl_airports
AS
  /**===============================================*\
  Name...............:   pkg_etl_airports
  Contents...........:   Load data of airport entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_airports';
  INSERT INTO wrk_airports
  SELECT airport_name, airport_city, airport_iata, airport_icao, airport_faa FROM ext_airports;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_airports';
  INSERT INTO cls_airports
  SELECT airport_name, airport_city, airport_iata, airport_icao, case airport_faa when chr(13) then null else airport_faa end
  FROM wrk_airports
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_airports;