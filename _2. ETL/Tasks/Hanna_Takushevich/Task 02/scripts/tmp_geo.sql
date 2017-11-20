CREATE TABLE tmp_geo (
    geo_id           NUMBER PRIMARY KEY,
    city_id          NUMBER,
    city_name        VARCHAR2(200),
    country_id       NUMBER,
    country_name     VARCHAR2(200),
    cc_fips          VARCHAR2(2),
    cc_iso           VARCHAR2(2),
    tld              VARCHAR2(3),
    subregion_id     NUMBER,
    subregion_name   VARCHAR2(200),
    region_id        NUMBER,
    region_name      VARCHAR2(200)
);

CREATE SEQUENCE geo_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

INSERT INTO tmp_geo SELECT
    geo_seq.NEXTVAL,
    city_id,
    city_name,
    co.country_id,
    country_name,
    cc_fips,
    cc_iso,
    tld,
    sub.subregion_id,
    subregion_name,
    reg.region_id,
    region_name
FROM
    ce_cities ci
    JOIN ce_countries co ON ci.country_id = co.country_id
    JOIN ce_subregions sub ON sub.subregion_id = co.subregion_id
    JOIN ce_regions reg ON reg.region_id = sub.region_id
WHERE
    city_id <= 2500000;

COMMIT;