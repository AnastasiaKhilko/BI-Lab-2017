CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_flights
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_flights
  Contents...........:   Load data of flight entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_dim
IS
BEGIN
  MERGE INTO dim_flights r USING
  (SELECT flight_id,
    route_id,
    aircraft_id,
    flight_code,
    route_code,
    aircraft_type,
    engines_num,
    flight_duration,
    to_date(flight_date) AS flight_date
  FROM cls_dim_flights
  MINUS
  SELECT flight_id,
    route_id,
    aircraft_id,
    flight_code,
    route_code,
    aircraft_type,
    engines_num,
    flight_duration,
    flight_date
  FROM dim_flights
  ) cls ON ( cls.flight_code = r.flight_code)
WHEN MATCHED THEN
  UPDATE
  SET r.flight_duration = cls.flight_duration,
    r.flight_date       = to_date(cls.flight_date),
    r.update_dt         = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      flight_surr_id,
      flight_id,
      route_id,
      aircraft_id,
      flight_code,
      route_code,
      aircraft_type,
      engines_num,
      flight_duration,
      flight_date
    )
    VALUES
    (
      dim_flight_seq.nextval ,
      cls.flight_id,
      cls.route_id,
      cls.aircraft_id,
      cls.flight_code,
      cls.route_code,
      cls.aircraft_type,
      cls.engines_num,
      cls.flight_duration,
      to_date(cls.flight_date)
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_dim;
END pkg_etl_dim_flights;