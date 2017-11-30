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
PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_flights r USING
  (SELECT flight_code,
    route_code,
    airline_name,
    flight_duration,
    flight_date,
    trim(leading chr(39)
  FROM trim(both chr(13)
  FROM aircraft_type)) AS aircraft_type
  FROM cls_flights
  MINUS
  SELECT flight_code,
    (SELECT route_code FROM ce_routes WHERE route_id = cf.route_id
    ),
    (SELECT airline_name FROM ce_airlines WHERE airline_id = cf.airline_id
    ),
    flight_duration,
    flight_date,
    (SELECT aircraft_type FROM ce_aircrafts WHERE aircraft_id=cf.aircraft_id
    )
  FROM ce_flights cf
  ) cls ON ( cls.flight_code = r.flight_code )
WHEN MATCHED THEN
  UPDATE
  SET r.route_id =
    (SELECT route_id FROM ce_routes WHERE route_code = cls.route_code
    ),
    r.airline_id =
    (SELECT airline_id FROM ce_airlines WHERE airline_name = cls.airline_name
    ),
    r.flight_duration = cls.flight_duration,
    r.flight_date     = cls.flight_date,
    r.aircraft_id     =
    (SELECT aircraft_id
    FROM ce_aircrafts
    WHERE aircraft_type = trim(leading chr(39)
    FROM trim(both chr(13)
    FROM cls.aircraft_type))
    ) WHEN NOT MATCHED THEN
  INSERT
    (
      flight_id,
      flight_code,
      route_id,
      airline_id,
      flight_duration,
      flight_date,
      aircraft_id,
      update_dt,
      insert_dt
    )
    VALUES
    (
      flight_seq.nextval ,
      cls.flight_code,
      (SELECT route_id FROM ce_routes WHERE route_code = cls.route_code
      ),
      (SELECT airline_id FROM ce_airlines WHERE airline_name = cls.airline_name
      ),
      cls.flight_duration,
      cls.flight_date,
      (SELECT aircraft_id
      FROM ce_aircrafts
      WHERE aircraft_type = trim(leading chr(39)
      FROM trim(both chr(13)
      FROM cls.aircraft_type))
      ),
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_flights;