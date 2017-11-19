CREATE TABLE ce_regions (
  region_id NUMBER(4) PRIMARY KEY,
  region_code NUMBER(4),
  region_child_code NUMBER(4),
  region_desc VARCHAR(255),
  continent_id NUMBER(4)
  );