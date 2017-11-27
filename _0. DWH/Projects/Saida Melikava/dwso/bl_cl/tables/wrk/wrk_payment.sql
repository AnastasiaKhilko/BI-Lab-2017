EXECUTE pckg_drop.drop_proc(object_name=>'wrk_payment', object_type=>'table');
CREATE TABLE wrk_payment
  (
    code       VARCHAR2 ( 200 CHAR ),
    type       VARCHAR2 ( 200 CHAR ),
    descr      VARCHAR2 ( 200 CHAR ),
    prepayment VARCHAR2 ( 200 CHAR )
  );