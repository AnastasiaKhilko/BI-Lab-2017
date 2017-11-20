CREATE TABLE ce_regions
  (
    region_id    NUMBER(10,0) PRIMARY KEY,
    region_desc  VARCHAR2 ( 200 CHAR ) NOT NULL,
    continent_id NUMBER(10,0) NOT NULL,
    CONSTRAINT FK_continent_id FOREIGN KEY (continent_id) 
        REFERENCES ce_continents(continent_id)
  );