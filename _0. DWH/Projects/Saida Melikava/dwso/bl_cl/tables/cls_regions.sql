EXECUTE pckg_drop.drop_proc(object_name=>'cls_regions', object_type=>'table');
CREATE TABLE cls_regions
  (
    region_src_id NUMBER(8),
    region_code   VARCHAR2(20 CHAR),
    region_desc   VARCHAR2(60 CHAR),
    district_id   NUMBER(8)
  ); 