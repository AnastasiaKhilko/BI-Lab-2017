--==============================================================
-- Table: t_ce_flights
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_flights', Object_Type=>'TABLE');
CREATE TABLE ce_flights
  (
    flight_id       NUMBER,
    flight_code     VARCHAR2(12),
    route_id        NUMBER,
    airline_id      NUMBER,
    flight_duration VARCHAR2(10),
    flight_date     VARCHAR2(15),
    aircraft_id     NUMBER,
    update_dt       DATE,
    insert_dt       DATE,
    CONSTRAINT ce_flights_pk PRIMARY KEY (flight_id),
    CONSTRAINT flight_rote_fk FOREIGN KEY (route_id) REFERENCES ce_routes (route_id),
    CONSTRAINT flight_airline_fk FOREIGN KEY (airline_id) REFERENCES ce_airlines (airline_id),
    CONSTRAINT flight_aircraft_fk FOREIGN KEY (aircraft_id) REFERENCES ce_aircrafts (aircraft_id)
  );