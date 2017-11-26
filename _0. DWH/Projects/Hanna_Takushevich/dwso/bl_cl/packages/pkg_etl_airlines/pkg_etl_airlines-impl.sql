CREATE OR REPLACE PACKAGE BODY pkg_etl_airlines
AS
  /**===============================================*\
  Name...............:   pkg_etl_airlines
  Contents...........:   Load data of airline entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_airlines';
  INSERT INTO wrk_airlines
  SELECT * FROM ext_airlines;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_airlines';
  INSERT INTO cls_airlines
  SELECT airline_name,
    SUBSTR(icao_iata_codes, 1, 3),
    SUBSTR(icao_iata_codes, 7, 2),
    airline_country
  FROM wrk_airlines
  WHERE airline_country             IS NOT NULL
  AND SUBSTR(icao_iata_codes, 1, 3) IS NOT NULL;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_airlines;