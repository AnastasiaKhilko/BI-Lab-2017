CREATE TABLE address
  (
    address_id  NUMBER(8) PRIMARY KEY,
    address        VARCHAR2(60) NOT NULL,
    house_number NUMBER(8),
    city_id  NUMBER(8) NOT NULL,
    CONSTRAINT fk_addr_city FOREIGN KEY (city_id) REFERENCES cities(city_id)
  );