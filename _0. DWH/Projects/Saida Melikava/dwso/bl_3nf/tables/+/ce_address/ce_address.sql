DROP TABLE ce_address;
CREATE TABLE ce_address
  (
    address_code  NUMBER(8) PRIMARY KEY,
    address     VARCHAR2(60) NOT NULL,
    postal_code VARCHAR2(20) NOT NULL,
    city_code     NUMBER(8) NOT NULL,
    CONSTRAINT fk_addr_city FOREIGN KEY (city_code) REFERENCES ce_city(city_code)
  );