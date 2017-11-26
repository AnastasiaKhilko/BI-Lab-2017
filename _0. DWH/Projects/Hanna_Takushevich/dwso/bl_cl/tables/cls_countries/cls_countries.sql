--==============================================================
-- Table: t_ce_countries
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_countries', Object_Type=>'TABLE');

CREATE TABLE ce_countries
  (
    country_id number,
    subregion_id number,
    cc_fips               VARCHAR2(2),
    cc_iso                VARCHAR2(2),
    tld                   VARCHAR2(3),
    country_name          VARCHAR2(200),
--    subregion_country_key VARCHAR2(3)
    CONSTRAINT ce_countries_pk PRIMARY KEY (country_id),
    CONSTRAINT country_subregion_fk FOREIGN KEY (subregion_id) REFERENCES ce_subregions (subregion_id)
  );