CREATE TABLE dim_flights (
    flight_id             NUMBER,
    route_id              NUMBER,
    aircraf_id            NUMBER,
    flight_code           VARCHAR2(10),
    departure_date_time   DATE,
    duration_minutes      NUMBER,
    aircraft_code         VARCHAR2(10),
    aircraft_name         VARCHAR2(50),
    CONSTRAINT dim_flights_pk PRIMARY KEY ( flight_id )
);