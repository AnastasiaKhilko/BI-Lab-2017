--==============================================================
-- Table: t_wrk_aircrafts
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_aircrafts', Object_Type=>'TABLE');
CREATE TABLE wrk_aircrafts
  (
    aircraft_type     VARCHAR2(50),
    aircraft_country  VARCHAR2(50),
    engines_num       NUMBER,
  );