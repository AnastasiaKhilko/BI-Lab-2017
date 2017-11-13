CREATE TABLE ce_country
  (
    country_id NUMBER(8) PRIMARY KEY,
    country    VARCHAR2(60) NOT NULL,
    region_id  NUMBER(8) NOT NULL,
    CONSTRAINT fk_coun_reg FOREIGN KEY (region_id) REFERENCES ce_region(region_id)
  );