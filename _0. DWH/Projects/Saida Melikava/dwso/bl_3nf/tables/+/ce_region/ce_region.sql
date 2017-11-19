DROP TABLE ce_region;
CREATE TABLE ce_region
  (
    region_code NUMBER(8) PRIMARY KEY,
    region    VARCHAR2(60) NOT NULL
  );