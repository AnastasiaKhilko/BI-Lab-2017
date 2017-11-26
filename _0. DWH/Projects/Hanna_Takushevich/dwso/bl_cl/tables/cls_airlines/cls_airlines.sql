--==============================================================
-- Table: t_cls_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_airlines', Object_Type=>'TABLE');
CREATE TABLE cls_airlines
  (
    airline_name    VARCHAR2(60),
    icao_codes VARCHAR2(3),
    iata_codes VARCHAR2(2),
    airline_country VARCHAR2(60)
  );