DROP TABLE ce_city;  
CREATE TABLE ce_city
  (
    city_code NUMBER(8) PRIMARY KEY,
    city    VARCHAR2(60) NOT NULL,
    country_code  NUMBER(8) NOT NULL,
    CONSTRAINT fk_city_coun FOREIGN KEY (country_code) REFERENCES ce_country(country_code)
  );