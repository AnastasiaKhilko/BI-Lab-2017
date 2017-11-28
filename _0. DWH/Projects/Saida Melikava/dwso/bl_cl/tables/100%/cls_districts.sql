EXECUTE pckg_drop.drop_proc(object_name=>'cls_districts', object_type=>'table');
CREATE TABLE cls_districts
  (
    district_code VARCHAR2(20 CHAR),
    district_desc VARCHAR2(60 CHAR) 
  );