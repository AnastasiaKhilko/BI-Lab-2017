EXECUTE pckg_drop.drop_proc(object_name=>'ext_payment', object_type=>'table');
CREATE TABLE ext_payment
  (
    code       VARCHAR2 ( 200 CHAR ),
    type       VARCHAR2 ( 200 CHAR ),
    descr      VARCHAR2 ( 200 CHAR ),
    prepayment VARCHAR2 ( 200 CHAR )
  )
  ORGANIZATION EXTERNAL
  (
    Type oracle_loader DEFAULT directory ETL access parameters (fields terminated BY ';' ) location ('payment.csv')
  )
  reject limit unlimited;
/
SELECT * FROM ext_payment
;
