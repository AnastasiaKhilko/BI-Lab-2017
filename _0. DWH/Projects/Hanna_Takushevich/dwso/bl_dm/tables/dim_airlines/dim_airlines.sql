CREATE TABLE dim_airlines (
    airline_id        NUMBER,
    airline_name      VARCHAR2(60),
    iata_code         VARCHAR2(2),
    icao_code         VARCHAR2(3),
    airline_counrty   VARCHAR2(50),
    start_dt         DATE,
    end_dt           DATE,
    is_active        VARCHAR2(1),
    CONSTRAINT dim_airlines_pk PRIMARY KEY ( airline_id )
);