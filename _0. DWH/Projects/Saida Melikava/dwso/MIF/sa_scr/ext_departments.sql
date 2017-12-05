EXECUTE pckg_drop.drop_proc(object_name=>'ext_departments', object_type=>'table');
CREATE TABLE ext_departments
  (
    dep_code  NUMBER(8),
    dep__name VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('dep_csv.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_departments;
