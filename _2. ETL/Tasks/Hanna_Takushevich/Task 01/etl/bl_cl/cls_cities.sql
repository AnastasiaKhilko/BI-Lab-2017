CREATE TABLE cls_cities (
    city_id      NUMBER,
    country_id   NUMBER,
    city_name    VARCHAR2(200 CHAR)
);

INSERT INTO cls_cities SELECT
    city_id,
    country_id,
    city_name
FROM
    wrk_cities;