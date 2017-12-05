EXECUTE pckg_drop.drop_proc(object_name=>'ext_employee',object_type=>'table');
CREATE TABLE ext_employee
  (
    code       NUMBER(8),
    surname    VARCHAR2 ( 200 CHAR ),
    name       VARCHAR2 ( 200 CHAR ),
    patronymic VARCHAR2 ( 200 CHAR ),
    sex        VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    emai       VARCHAR2 ( 200 CHAR ),
    city       VARCHAR2 ( 200 CHAR ),
    born       VARCHAR2 ( 200 CHAR ),
    n_passport VARCHAR2 ( 200 CHAR ),
    when_pas   VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('zaym1.csv')
  )
  reject limit unlimited;
/
SELECT *FROM ext_employee;
