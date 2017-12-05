EXECUTE pckg_drop.drop_proc(object_name=>'wrk_departments', object_type=>'table');
CREATE TABLE wrk_departments
  (
    dep_code NUMBER(8),
    dep_name VARCHAR2(250 CHAR)
  ); 