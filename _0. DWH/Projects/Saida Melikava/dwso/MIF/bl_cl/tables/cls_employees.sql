EXECUTE pckg_drop.drop_proc(object_name=>'cls_employees', object_type=>'table');
CREATE TABLE cls_employees
  (
    code     VARCHAR2 ( 200 CHAR ),
    surname  VARCHAR2 ( 200 CHAR ),
    name     VARCHAR2 ( 200 CHAR ),
    phone    VARCHAR2 ( 200 CHAR ),
    email    VARCHAR2 ( 200 CHAR ),
    dep_id   NUMBER(8),
    man_id   NUMBER(8),
    store_id NUMBER(8)
  ); 