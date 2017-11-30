--==============================================================
-- Table: t_ce_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_airlines', Object_Type=>'TABLE');
CREATE TABLE ce_airlines
  (
    airline_id      NUMBER PRIMARY KEY,
    airline_name    VARCHAR2(60),
    icao_codes      VARCHAR2(3),
    iata_codes      VARCHAR2(2),
    airline_country VARCHAR2(60),
    insert_dt       DATE,
    update_dt       DATE
  );
