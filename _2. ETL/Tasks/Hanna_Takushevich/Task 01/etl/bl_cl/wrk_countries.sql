CREATE TABLE wrk_countries (
    country_id              NUMBER,
    cc_fips                 VARCHAR2(2),
    cc_iso                  VARCHAR2(2),
    tld                     VARCHAR2(3),
    country_name            VARCHAR2(200 CHAR),
    subregion_country_key   NUMBER(2),
    subregion_id            NUMBER
);

INSERT INTO wrk_countries SELECT
    country_seq.NEXTVAL,
    cc_fips,
    cc_iso,
    tld,
    country_name,
    wrk_subregions.subregion_country_key,
    subregion_id
FROM
    wrk_countries_initial
    INNER JOIN wrk_subregions ON wrk_subregions.subregion_country_key = wrk_countries_initial.subregion_country_key;