--==============================================================
-- Table: t_wrk_flight_aircraft
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_flight_aircraft', Object_Type=>'TABLE');
CREATE TABLE wrk_flight_aircraft
  (
    flight_code   VARCHAR2(20),
    aircraft_type VARCHAR2(60)
  );