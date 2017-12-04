-- WRK_PAYMENT_METHODS.
DROP TABLE wrk_payment_methods;
CREATE TABLE wrk_payment_methods
  (
    payment_method_name VARCHAR2 ( 200 CHAR ),
    start_dt            DATE,
    end_dt              DATE,
    is_active           VARCHAR2 ( 100 BYTE )
  );