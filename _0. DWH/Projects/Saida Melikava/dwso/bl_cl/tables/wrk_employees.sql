EXECUTE pckg_drop.drop_proc(object_name=>'wrk_employees',object_type=>'table');
CREATE TABLE wrk_employees
  (
    code       VARCHAR2 ( 200 CHAR ),
    surname    VARCHAR2 ( 200 CHAR ),
    name       VARCHAR2 ( 200 CHAR ),
    patronymic VARCHAR2 ( 200 CHAR ),
    sex        VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    email       VARCHAR2 ( 200 CHAR ),
    city       VARCHAR2 ( 200 CHAR ),
    born       VARCHAR2 ( 200 CHAR ),
    n_passport VARCHAR2 ( 200 CHAR ),
    when_pas   VARCHAR2 ( 200 CHAR )
  );