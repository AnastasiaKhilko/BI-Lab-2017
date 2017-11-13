CREATE TABLE ce_subregions
  (
    subregion_id   NUMBER,
    region_id      NUMBER,
    subregion_name VARCHAR2(50),
    CONSTRAINT ce_subregions_pk PRIMARY KEY (subregion_id),
    CONSTRAINT subregion_region_fk FOREIGN KEY (region_id) REFERENCES ce_regions (region_id)
  );