--==============================================================
-- Table: t_wrk_subregions
--==============================================================

EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_subregions', Object_Type=>'TABLE');

CREATE TABLE wrk_subregions
  (
    subregion_code        VARCHAR2(4),
    subregion_name        VARCHAR2(200),
    subregion_country_key VARCHAR2(3)
  );