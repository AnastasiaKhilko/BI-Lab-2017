--==============================================================
-- Table: t_wrk_countries
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_countries', Object_Type=>'TABLE');

CREATE TABLE wrk_countries
  (
    cc_fips               VARCHAR2(4),
    cc_iso                VARCHAR2(4),
    tld                   VARCHAR2(5),
    country_name          VARCHAR2(200),
    subregion_country_key VARCHAR2(4)
  );