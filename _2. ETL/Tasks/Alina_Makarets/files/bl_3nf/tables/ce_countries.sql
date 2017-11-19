CREATE TABLE ce_countries
  (
    country_id   NUMBER(10,0) PRIMARY KEY NOT NULL,
    country_desc VARCHAR2 ( 200 CHAR ) NOT NULL,
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER(10,0)NOT NULL ,
    CONSTRAINT FK_country_id FOREIGN KEY (region_id) 
        REFERENCES ce_regions(region_id)
  );
