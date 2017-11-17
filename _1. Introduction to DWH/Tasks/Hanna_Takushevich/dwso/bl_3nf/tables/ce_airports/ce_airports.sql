CREATE TABLE ce_airports
  (
    airport_id   NUMBER,
    city_id      NUMBER,
    airport_name VARCHAR2(100),
    airport_iata VARCHAR2(3),
    airport_icao VARCHAR2(4),
    airport_faa  VARCHAR2(4),
    CONSTRAINT ce_airports_pk PRIMARY KEY (airport_id),
    CONSTRAINT airport_city_fk FOREIGN KEY (city_id) REFERENCES ce_cities (city_id)
  );