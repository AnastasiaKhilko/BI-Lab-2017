CREATE TABLE ce_airlines (
    airline_id        NUMBER,
    airline_name      VARCHAR2(60),
    iata_code         VARCHAR2(2),
    icao_code         VARCHAR2(3),
    airline_counrty   VARCHAR2(50),
    CONSTRAINT ce_airlines_pk PRIMARY KEY ( airline_id )
);