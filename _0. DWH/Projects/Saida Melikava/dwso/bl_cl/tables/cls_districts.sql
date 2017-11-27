EXECUTE pckg_drop.drop_proc(object_name=>'cls_districts', object_type=>'table');
CREATE TABLE cls_districts
  (
    distr_src_id  NUMBER(8),
    district_code VARCHAR2(20 CHAR),
    district_desc VARCHAR2(60 CHAR) 
  );