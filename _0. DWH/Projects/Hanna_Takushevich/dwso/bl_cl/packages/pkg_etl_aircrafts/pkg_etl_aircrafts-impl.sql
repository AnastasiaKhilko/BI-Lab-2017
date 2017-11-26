CREATE OR REPLACE PACKAGE BODY pkg_etl_aircrafts
AS
  /**===============================================*\
  Name...............:   pkg_etl_aircrafts
  Contents...........:   Load data of aircraft entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_aircrafts';
  INSERT INTO wrk_aircrafts
  SELECT aircraft_type, aircraft_country, engines_num FROM ext_aircrafts;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_aircrafts';
  INSERT INTO cls_aircrafts
  SELECT aircraft_type,
    CASE
      WHEN instr(aircraft_country, '[')!=0
      THEN SUBSTR(aircraft_country, 1, LENGTH(aircraft_country)-4)
      ELSE aircraft_country
    END,
    engines_num
  FROM wrk_aircrafts;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_aircrafts;