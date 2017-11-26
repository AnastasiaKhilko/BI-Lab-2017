--==============================================================
-- Table: t_cls_regions
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_regions', Object_Type=>'TABLE');

CREATE TABLE cls_regions
  ( region_code NUMBER(2), 
    region_name VARCHAR2(200)
  );