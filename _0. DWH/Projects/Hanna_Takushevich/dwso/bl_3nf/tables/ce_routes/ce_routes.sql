--==============================================================
-- Table: t_ce_routes
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_routes', Object_Type=>'TABLE');
CREATE TABLE ce_routes
  (
    route_id        NUMBER,
    route_code      VARCHAR2(10),
    airport_from_id NUMBER,
    airport_to_id   NUMBER,
    insert_dt       DATE,
    update_dt       DATE,
    CONSTRAINT ce_routes_pk PRIMARY KEY (route_id),
    CONSTRAINT route_departure_airport_fk FOREIGN KEY (airport_from_id) REFERENCES ce_airports (airport_id),
    CONSTRAINT route_destination_airport_fk FOREIGN KEY (airport_to_id) REFERENCES ce_airports (airport_id)
  );