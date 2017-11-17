CREATE TABLE ce_countries
  (
    country_id   NUMBER,
    subregion_id NUMBER,
    cc_fips      VARCHAR2(2),
    cc_iso       VARCHAR2(2),
    country_name VARCHAR2(50),
    CONSTRAINT ce_countries_pk PRIMARY KEY (country_id),
    CONSTRAINT country_subregion_fk FOREIGN KEY (subregion_id) REFERENCES ce_subregions (subregion_id)
  );