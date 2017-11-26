--==============================================================
-- Table: t_ce_subregions
--==============================================================

EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_subregions', Object_Type=>'TABLE');

CREATE TABLE ce_subregions
  (
    subregion_id NUMBER,
    region_id NUMBER,
    subregion_code        VARCHAR2(2),
    subregion_name        VARCHAR2(200),
    CONSTRAINT ce_subregions_pk PRIMARY KEY (subregion_id),
    CONSTRAINT subregion_region_fk FOREIGN KEY (region_id) REFERENCES ce_regions (region_id)
  );