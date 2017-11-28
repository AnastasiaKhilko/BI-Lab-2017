DROP TABLE ce_regions;
CREATE TABLE ce_regions
  (
    region_id NUMBER(8) PRIMARY KEY,
    region    VARCHAR2(60) NOT NULL,
    insert_DT DATE NOT NULL,
    update_DT DATE NOT NULL
  );