  CREATE TABLE ce_city
  (
    city_id NUMBER(8) PRIMARY KEY,
    city    VARCHAR2(60) NOT NULL,
    country_id  NUMBER(8) NOT NULL,
    CONSTRAINT fk_city_coun FOREIGN KEY (country_id) REFERENCES ce_country(country_id)
  );