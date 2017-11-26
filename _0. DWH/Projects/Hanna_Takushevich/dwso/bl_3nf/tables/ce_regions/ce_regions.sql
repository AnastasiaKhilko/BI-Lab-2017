--==============================================================
-- Table: t_ce_regions
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_regions', Object_Type=>'TABLE');

CREATE TABLE ce_regions
  (
    region_id   NUMBER,
    region_code NUMBER(2), 
    region_name VARCHAR2(25),
    CONSTRAINT ce_regions_pk PRIMARY KEY (region_id)
  );