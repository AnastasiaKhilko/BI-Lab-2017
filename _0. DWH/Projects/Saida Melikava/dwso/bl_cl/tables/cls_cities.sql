EXECUTE pckg_drop.drop_proc(object_name=>'cls_cities', object_type=>'table');
CREATE TABLE cls_cities
  (
    city_src_id NUMBER(8),
    city_code   VARCHAR2(20 CHAR),
    city_desc   VARCHAR2(60 CHAR),
    region_id   NUMBER(8)
  );