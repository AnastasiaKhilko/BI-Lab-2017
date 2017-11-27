CREATE TABLE ce_cities
  (
    city_id NUMBER(8) PRIMARY KEY,
    city    VARCHAR2(60) NOT NULL,
    country_id  NUMBER(8) NOT NULL,
    insert_DT DATE NOT NULL,
    update_DT DATE NOT NULL,
    CONSTRAINT fk_city_coun FOREIGN KEY (country_id) REFERENCES ce_countries (country_id)
  );