CREATE SEQUENCE city_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE wrk_cities_initial (
    city_id     NUMBER,
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200 CHAR)
);

INSERT INTO wrk_cities_initial SELECT
    city_seq.NEXTVAL,
    cc_fips,
    city_name
FROM
    ext_geo_cities;