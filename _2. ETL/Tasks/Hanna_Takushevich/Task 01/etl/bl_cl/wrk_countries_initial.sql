CREATE SEQUENCE country_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE wrk_countries_initial (
    country_id              NUMBER,
    cc_fips                 VARCHAR2(2),
    cc_iso                  VARCHAR2(2),
    tld                     VARCHAR2(3),
    country_name            VARCHAR2(200 CHAR),
    subregion_country_key   NUMBER(2)
);

INSERT INTO wrk_countries_initial (
    country_id,
    cc_fips,
    cc_iso,
    tld,
    country_name,
    subregion_country_key
) SELECT
    subreg_seq.NEXTVAL,
    cc_fips,
    cc_iso,
    tld,
    country_name,
    subregion_country_key
FROM
    ext_geo_countries;