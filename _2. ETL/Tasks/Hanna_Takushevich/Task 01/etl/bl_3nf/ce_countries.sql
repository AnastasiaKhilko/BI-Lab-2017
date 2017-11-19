CREATE TABLE ce_countries (
    country_id     NUMBER PRIMARY KEY,
    subregion_id   NUMBER,
    cc_fips        VARCHAR2(2),
    cc_iso         VARCHAR2(2),
    tld            VARCHAR2(3),
    country_name   VARCHAR2(200 CHAR),
    CONSTRAINT fk_country_subregion FOREIGN KEY ( subregion_id )
        REFERENCES ce_subregions ( subregion_id )
);

INSERT INTO ce_countries SELECT
    *
FROM
    cls_countries;