EXECUTE pckg_drop.drop_proc(object_name=>'cls_employees', object_type=>'table');
CREATE TABLE cls_employees
  (
    emp_src_id NUMBER(8),
    code       VARCHAR2 ( 200 CHAR ),
    surname    VARCHAR2 ( 200 CHAR ),
    name       VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    email      VARCHAR2 ( 200 CHAR ),
    dep_id VARCHAR2 ( 200 CHAR ),
    man_id VARCHAR2 ( 200 CHAR )
  );
EXECUTE pckg_drop.drop_proc(object_name=>'cls_employees_error', object_type=>'table');
CREATE TABLE cls_employees_error
  (
    code    VARCHAR2 ( 200 CHAR ),
    surname VARCHAR2 ( 200 CHAR ),
    name    VARCHAR2 ( 200 CHAR ),
    phone   VARCHAR2 ( 200 CHAR ),
    email   VARCHAR2 ( 200 CHAR )
  );