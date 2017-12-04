DROP TABLE ce_regions CASCADE CONSTRAINTS;
CREATE TABLE ce_regions
  (
    region_id NUMBER(8) PRIMARY KEY,
    region_code   VARCHAR2(20 CHAR) NOT NULL,
    region_desc   VARCHAR2(60 CHAR) NOT NULL,
    district_id NUMBER(8) NOT NULL,
    insert_DT   DATE default(sysdate) NOT NULL ,
    update_DT   DATE default(sysdate) NOT NULL
  ); 
  
  ALTER TABLE ce_regions 
  ADD CONSTRAINT fk_3nf_ce_regions
  FOREIGN KEY(district_id) REFERENCES ce_districts(district_id);