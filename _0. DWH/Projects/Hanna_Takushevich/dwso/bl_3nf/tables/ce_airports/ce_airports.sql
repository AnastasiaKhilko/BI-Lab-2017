--==============================================================
-- Table: t_ce_airports
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_airports', Object_Type=>'TABLE');
CREATE TABLE ce_airports
  (
    airport_id   NUMBER,
    airport_name VARCHAR2(150),
    city_id      NUMBER,
    airport_iata VARCHAR2(3),
    airport_icao VARCHAR2(4),
    airport_faa  VARCHAR2(5),
    insert_dt    DATE,
    update_dt    DATE,
    CONSTRAINT ce_airports_pk PRIMARY KEY (airport_id),
    CONSTRAINT airport_city_fk FOREIGN KEY (city_id) REFERENCES ce_cities (city_id)
  ); 