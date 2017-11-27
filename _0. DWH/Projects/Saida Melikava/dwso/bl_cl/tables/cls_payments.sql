EXECUTE pckg_drop.drop_proc(object_name=>'cls_payments', object_type=>'table');
CREATE TABLE cls_payments
  (
    code       NUMBER(8),
    type       VARCHAR2 ( 200 CHAR ),
    descr      VARCHAR2 ( 200 CHAR ),
    prepayment VARCHAR2 ( 200 CHAR )
  );