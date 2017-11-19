CREATE TABLE cls_countries (
    country_id     NUMBER,
    subregion_id   NUMBER,
    cc_fips        VARCHAR2(2),
    cc_iso         VARCHAR2(2),
    tld            VARCHAR2(3),
    country_name   VARCHAR2(200 CHAR)
);

INSERT INTO cls_countries SELECT
    country_id,
    subregion_id,
    cc_fips,
    cc_iso,
    tld,
    country_name
FROM
    wrk_countries;