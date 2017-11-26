--==============================================================
-- Table: t_cls_flights
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_flights', Object_Type=>'TABLE');
CREATE TABLE cls_flights
  (
    route_code      VARCHAR2(10),
    airline_name    VARCHAR2(60),
    flight_duration VARCHAR2(10),
    flight_code     VARCHAR2(12),
    flight_date     VARCHAR2(15),
    aircraft_type   VARCHAR2(60)
  );