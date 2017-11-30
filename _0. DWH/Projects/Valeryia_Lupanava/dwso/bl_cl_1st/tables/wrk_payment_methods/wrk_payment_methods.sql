-- WRK_PAYMENT_METHODS.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_payment_methods', object_type => 'table');
END;

CREATE TABLE wrk_payment_methods
  (
    payment_method_name VARCHAR2 ( 200 CHAR ),
    bank                VARCHAR2 ( 200 CHAR ),
    start_dt            DATE,
    end_dt              DATE,
    is_active           VARCHAR2 ( 100 BYTE )
  );