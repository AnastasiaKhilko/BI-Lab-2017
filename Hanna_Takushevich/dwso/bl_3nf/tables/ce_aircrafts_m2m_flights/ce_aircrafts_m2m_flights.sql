CREATE TABLE ce_aircrafts_m2m_flights
  (
    aircraft_id NUMBER,
    flight_id   NUMBER,
    CONSTRAINT ce_aircrafts_m2m_flights_pk PRIMARY KEY (aircraft_id, flight_id),
    CONSTRAINT m2m_flight_fk FOREIGN KEY (flight_id) REFERENCES ce_flights (flight_id),
    CONSTRAINT m2m_aircraft_fk FOREIGN KEY (aircraft_id) REFERENCES ce_aircrafts (aircraft_id)
  );