CREATE TABLE ce_cities (
    city_id      NUMBER PRIMARY KEY,
    country_id   NUMBER,
    city_name    VARCHAR2(200 CHAR),
    CONSTRAINT fk_city_country FOREIGN KEY ( country_id )
        REFERENCES ce_countries ( country_id )
);

INSERT INTO ce_cities SELECT
    *
FROM
    cls_cities;