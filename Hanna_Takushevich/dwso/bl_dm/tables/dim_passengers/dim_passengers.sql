CREATE TABLE dim_passengers (
    passenger_id     NUMBER,
    city_id          NUMBER,
    country_id       NUMBER,
    subregion_id     NUMBER,
    region_id        NUMBER,
    first_name       VARCHAR2(255),
    middle_name      VARCHAR2(255),
    family_name      VARCHAR2(255),
    passport         VARCHAR2(50),
    birthday         DATE,
    phone            VARCHAR2(25),
    email            VARCHAR2(100),
    city_name        VARCHAR2(50),
    country_name     VARCHAR2(50),
    subregion_name   VARCHAR2(50),
    region_name      VARCHAR2(50),
    CONSTRAINT dim_passengers_pk PRIMARY KEY ( passenger_id )
);