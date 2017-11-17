CREATE TABLE ce_passengers
  (
    passenger_id NUMBER,
    city_id      NUMBER,
    first_name   VARCHAR2(255),
    middle_name  VARCHAR2(255),
    family_name  VARCHAR2(255),
    passport     VARCHAR2(50),
    birthday     DATE,
    phone        VARCHAR2(25),
    email        VARCHAR2(100),
    CONSTRAINT ce_passengers_pk PRIMARY KEY (passenger_id),
    CONSTRAINT passenger_city_fk FOREIGN KEY (city_id) REFERENCES ce_cities (city_id)
  );