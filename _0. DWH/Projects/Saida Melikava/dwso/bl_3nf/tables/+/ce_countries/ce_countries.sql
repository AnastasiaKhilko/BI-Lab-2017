CREATE TABLE ce_countries
  (
    country_id  NUMBER(8) PRIMARY KEY,
    country     VARCHAR2(60) NOT NULL,
    region_id NUMBER(8) NOT NULL,
    insert_DT   DATE NOT NULL,
    update_DT   DATE NOT NULL,
    CONSTRAINT fk_coun_reg FOREIGN KEY (region_id) REFERENCES ce_regions(region_id)
  );
  