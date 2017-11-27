CREATE TABLE ce_addresses
  (
    address_id  NUMBER(8) PRIMARY KEY,
    address     VARCHAR2(60) NOT NULL,
    postal_code VARCHAR2(20) NOT NULL,
    city_id     NUMBER(8) NOT NULL,
    CONSTRAINT fk_addr_city FOREIGN KEY (city_id) REFERENCES ce_cities(city_id)
  );