CREATE TABLE ce_flights (
    flight_id             NUMBER,
    route_id              NUMBER,
    airline_id            NUMBER,
    flight_code           VARCHAR2(10),
    departure_date_time   DATE,
    duration_minutes      NUMBER,
    CONSTRAINT ce_flights_pk PRIMARY KEY ( flight_id ),
    CONSTRAINT flight_rote_fk FOREIGN KEY ( route_id )
        REFERENCES ce_routes ( route_id ),
    CONSTRAINT flight_airline_fk FOREIGN KEY ( airline_id )
        REFERENCES ce_airlines ( airline_id )
);