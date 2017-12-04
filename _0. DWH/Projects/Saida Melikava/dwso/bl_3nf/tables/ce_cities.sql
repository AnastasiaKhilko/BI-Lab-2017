DROP TABLE ce_cities CASCADE CONSTRAINTS;
CREATE TABLE ce_cities
  (
    city_id NUMBER(8) PRIMARY KEY,
    city_code   VARCHAR2(20 CHAR) NOT NULL,
    city_desc   VARCHAR2(60 CHAR) NOT NULL,
    region_id NUMBER(8) NOT NULL,
    insert_DT   DATE default(sysdate) NOT NULL ,
    update_DT   DATE default(sysdate) NOT NULL
    
  );
  
  ALTER TABLE ce_cities 
  ADD CONSTRAINT fk_3nf_ce_cities 
  FOREIGN KEY(region_id) REFERENCES ce_regions(region_id);
  
  