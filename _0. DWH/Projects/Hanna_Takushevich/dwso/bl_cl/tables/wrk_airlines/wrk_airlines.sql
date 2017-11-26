--==============================================================
-- Table: t_wrk_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_airlines', Object_Type=>'TABLE');
CREATE TABLE wrk_airlines
  (
    airline_name    VARCHAR2(60),
    icao_iata_codes VARCHAR2(8),
    airline_country VARCHAR2(60)
  );