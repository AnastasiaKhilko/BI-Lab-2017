CREATE TABLE ce_routes
  (
    route_id                  NUMBER,
    route_departure_airport   NUMBER,
    route_destination_airport NUMBER,
    CONSTRAINT ce_routes_pk PRIMARY KEY (route_id),
    CONSTRAINT route_departure_airport_fk FOREIGN KEY (route_departure_airport) REFERENCES ce_airports (airport_id),
    CONSTRAINT route_destination_airport_fk FOREIGN KEY (route_destination_airport) REFERENCES ce_airports (airport_id)
  );