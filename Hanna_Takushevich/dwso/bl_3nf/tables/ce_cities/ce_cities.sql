CREATE TABLE ce_cities
  (
    city_id    NUMBER,
    country_id NUMBER,
    city_name  VARCHAR2(50),
    CONSTRAINT ce_cities_pk PRIMARY KEY (city_id),
    CONSTRAINT city_country_fk FOREIGN KEY (country_id) REFERENCES ce_countries (country_id)
  );