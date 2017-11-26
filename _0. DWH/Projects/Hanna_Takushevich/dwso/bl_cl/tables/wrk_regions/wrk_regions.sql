--==============================================================
-- Table: t_wrk_regions
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'wrk_regions', Object_Type=>'TABLE');

CREATE TABLE wrk_regions
  ( region_code NUMBER(2), 
    region_name VARCHAR2(200)
  );