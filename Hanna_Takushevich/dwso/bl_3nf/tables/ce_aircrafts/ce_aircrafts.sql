CREATE TABLE ce_aircrafts
  (
    aircraft_id        NUMBER,
    aircraft_code      VARCHAR2(10),
    aircraft_name      VARCHAR2(50),
    commissioning_date DATE,
    CONSTRAINT ce_aircrafts_pk PRIMARY KEY (aircraft_id)
  );