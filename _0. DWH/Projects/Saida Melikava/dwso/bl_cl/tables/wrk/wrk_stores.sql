EXECUTE pckg_drop.drop_proc(object_name=>'wrk_stores', object_type=>'table');
CREATE TABLE wrk_stores
  (
    code         VARCHAR2 ( 200 CHAR ),
    name         VARCHAR2 ( 200 CHAR ),
    city         VARCHAR2 ( 200 CHAR ),
    street       VARCHAR2 ( 200 CHAR ),
    number_house VARCHAR2 ( 200 CHAR )
  );