--==============================================================
-- Table: t_cls_airports
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_airports', Object_Type=>'TABLE');
CREATE TABLE cls_airports
  (
    airport_name VARCHAR2(150),
    airport_city VARCHAR2(50),
    airport_iata VARCHAR2(3),
    airport_icao VARCHAR2(4),
    airport_faa  VARCHAR2(5)
  ); 