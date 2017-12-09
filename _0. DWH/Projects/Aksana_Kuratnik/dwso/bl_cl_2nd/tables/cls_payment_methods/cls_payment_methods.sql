--CLS_PAYMENT_METHODS.
DROP TABLE cls_payment_methods;
CREATE TABLE cls_payment_methods
  (
    payment_method_surr_id NUMBER(38) NOT NULL,
    payment_method_id      VARCHAR2(40 BYTE) NOT NULL,
    payment_method_name    VARCHAR2(40 BYTE) NOT NULL,
    start_dt               DATE DEFAULT '01-JAN-1990',
    end_dt                 DATE DEFAULT '31-DEC-9999',
    is_active              VARCHAR2 ( 200 CHAR ) NOT NULL
  );