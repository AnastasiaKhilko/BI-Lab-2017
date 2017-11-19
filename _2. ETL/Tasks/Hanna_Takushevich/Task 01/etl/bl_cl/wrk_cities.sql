CREATE TABLE wrk_cities (
    city_id      NUMBER,
    country_id   NUMBER,
    city_name    VARCHAR2(200 CHAR)
);

INSERT INTO wrk_cities SELECT
    city_id,
    country_id,
    city_name
FROM
    wrk_cities_initial
    JOIN wrk_countries ON wrk_cities_initial.cc_fips = wrk_countries.cc_fips;