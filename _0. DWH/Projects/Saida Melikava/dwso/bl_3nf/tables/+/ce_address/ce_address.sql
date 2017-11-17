CREATE TABLE ce_address
  (
    address_id  NUMBER(8) PRIMARY KEY,
    address        VARCHAR2(60) NOT NULL,
    postal_code VARCHAR2(20),
    city_id  NUMBER(8) NOT NULL,
    CONSTRAINT fk_addr_city FOREIGN KEY (city_id) REFERENCES ce_city(city_id)
  );