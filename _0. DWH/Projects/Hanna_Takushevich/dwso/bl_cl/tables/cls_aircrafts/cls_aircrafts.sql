--==============================================================
-- Table: t_cls_aircrafts
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_aircrafts', Object_Type=>'TABLE');
CREATE TABLE cls_aircrafts
  (
    aircraft_type     VARCHAR2(50),
    aircraft_country  VARCHAR2(50),
    engines_num       NUMBER
  );