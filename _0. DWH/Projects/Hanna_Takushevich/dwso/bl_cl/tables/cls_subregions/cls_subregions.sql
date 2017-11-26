--==============================================================
-- Table: t_cls_subregions
--==============================================================

EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_subregions', Object_Type=>'TABLE');

CREATE TABLE cls_subregions
  (
    subregion_code        VARCHAR2(2),
    subregion_name        VARCHAR2(200),
    subregion_country_key NUMBER(3)
  );