--==============================================================
-- Table: t_wrk_airports
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_airports', Object_Type=>'TABLE');
CREATE TABLE wrk_airports
  (
    airport_name VARCHAR2(150),
    airport_city VARCHAR2(50),
    airport_iata VARCHAR2(3),
    airport_icao VARCHAR2(4),
    airport_faa  VARCHAR2(5)
  ); 