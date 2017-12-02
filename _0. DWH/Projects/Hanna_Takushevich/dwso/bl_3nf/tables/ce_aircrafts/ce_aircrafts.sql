--==============================================================
-- Table: t_ce_aircrafts
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_aircrafts', Object_Type=>'TABLE');
CREATE TABLE ce_aircrafts
  (
    aircraft_id      NUMBER,
    aircraft_type    VARCHAR2(50),
    aircraft_country VARCHAR2(50),
    engines_num      NUMBER,
    update_dt        DATE,
    insert_dt        DATE,
    CONSTRAINT ce_aircrafts_pk PRIMARY KEY (aircraft_id)
  );