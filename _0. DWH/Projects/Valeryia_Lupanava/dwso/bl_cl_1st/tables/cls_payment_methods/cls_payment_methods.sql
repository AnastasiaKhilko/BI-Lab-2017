-- CLS_PAYMENT_METHODS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_payment_methods', object_type => 'table');
END;

CREATE TABLE cls_payment_methods
(
 payment_method      VARCHAR2 ( 200 CHAR ) NOT NULL,
 bank                VARCHAR2 ( 200 CHAR ) NOT NULL
);