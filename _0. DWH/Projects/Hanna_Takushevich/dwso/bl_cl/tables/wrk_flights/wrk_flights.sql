--==============================================================
-- Table: t_wrk_flights
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_flights', Object_Type=>'TABLE');
CREATE TABLE wrk_flights
  (
    route_code      VARCHAR2(10),
    airline_name    VARCHAR2(60),
    flight_duration VARCHAR2(10),
    flight_code     VARCHAR2(12),
    flight_date     VARCHAR2(15)
  );