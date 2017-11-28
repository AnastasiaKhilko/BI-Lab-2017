EXECUTE pckg_drop.drop_proc(object_name=>'cls_departments', object_type=>'table');
CREATE TABLE cls_departments
  (
    dep_src_id NUMBER(8),
    dep_code   NUMBER(8),
    dep_name   VARCHAR2(250 CHAR)
  ); 