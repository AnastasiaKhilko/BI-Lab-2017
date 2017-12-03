--==============================================================
-- Table: t_dim_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_airlines', Object_Type=>'TABLE');
CREATE TABLE dim_airlines
  (
    airline_surr_id NUMBER PRIMARY KEY,
    airline_id      NUMBER,
    airline_name    VARCHAR2(60),
    airline_iata    VARCHAR2(2),
    airline_icao    VARCHAR2(3),
    airline_country VARCHAR2(60),
    insert_dt       DATE DEFAULT sysdate,
    update_dt       DATE DEFAULT sysdate
  );