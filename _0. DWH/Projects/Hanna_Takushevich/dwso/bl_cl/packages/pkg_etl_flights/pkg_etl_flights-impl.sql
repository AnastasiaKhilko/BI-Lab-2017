CREATE OR REPLACE PACKAGE BODY pkg_etl_flights
AS
  /**===============================================*\
  Name...............:   pkg_etl_flights
  Contents...........:   Load data of flight entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_flights';
  EXECUTE IMMEDIATE 'truncate table wrk_flight_aircraft';
  INSERT INTO wrk_flights
  SELECT * FROM ext_flights;
  INSERT INTO wrk_flight_aircraft
  SELECT * FROM ext_flight_aircraft;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_flights';
  INSERT INTO cls_flights
  SELECT trim(both '"'
  FROM route_code),
    trim(both '"'
  FROM airline_name),
    to_number(flight_duration),
    trim(both '"'
  FROM fl.flight_code),
    to_date(SUBSTR(trim(both '"'
  FROM flight_date), 1, 9), 'dd-mon-yy'),
    aircraft_type
  FROM wrk_flights fl
  JOIN wrk_flight_aircraft ai
  ON trim(both '"'
  FROM fl.flight_code) = trim(both '"'
  FROM ai.flight_code);
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
END pkg_etl_flights;