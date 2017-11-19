DROP TABLE ce_country;  
CREATE TABLE ce_country
  (
    country_code NUMBER(8) PRIMARY KEY,
    country    VARCHAR2(60) NOT NULL,
    region_code  NUMBER(8) NOT NULL,
    CONSTRAINT fk_coun_reg FOREIGN KEY (region_code) REFERENCES ce_region(region_code)
  );