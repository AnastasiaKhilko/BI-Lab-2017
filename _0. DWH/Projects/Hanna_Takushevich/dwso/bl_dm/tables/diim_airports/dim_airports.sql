CREATE TABLE dim_airports (
    airport_id       NUMBER,
    city_id          NUMBER,
    country_id       NUMBER,
    subregion_id     NUMBER,
    region_id        NUMBER,
    airport_name     VARCHAR2(100),
    airport_iata     VARCHAR2(3),
    airport_icao     VARCHAR2(4),
    airport_faa      VARCHAR2(4),
    city_name        VARCHAR2(50),
    country_name     VARCHAR2(50),
    subregion_name   VARCHAR2(50),
    region_name      VARCHAR2(50),
    start_dt         DATE,
    end_dt           DATE,
    is_active        VARCHAR2(1),
    CONSTRAINT dim_airports_pk PRIMARY KEY ( airport_id )
);