--==============================================================
-- Table: t_dim_flights
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_flights', Object_Type=>'TABLE');
CREATE TABLE dim_flights
  (
    flight_surr_id  NUMBER PRIMARY KEY,
    flight_id       NUMBER,
    route_id        NUMBER,
    aircraft_id     NUMBER,
    flight_code     VARCHAR2(12),
    route_code      VARCHAR2(10),
    aircraft_type   VARCHAR2(50),
    engines_num     NUMBER,
    flight_duration VARCHAR2(10),
    flight_date     DATE,
    insert_dt       DATE DEFAULT sysdate,
    update_dt       DATE DEFAULT sysdate
  );