--CE_PAYMENT_METHODS.
DROP TABLE ce_payment_methods;
CREATE TABLE ce_payment_methods
  (
    payment_method_id    NUMBER(10) NOT NULL,
    payment_method_srcid VARCHAR2(40 BYTE) NOT NULL,
    payment_method_desc  VARCHAR2(40 BYTE) NOT NULL,
    start_dt             DATE DEFAULT '01-JAN-1990',
    end_dt               DATE DEFAULT '31-DEC-9999',
    is_active            VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT payment_method_id_pk PRIMARY KEY ( payment_method_id ),
    CONSTRAINT payment_method_srcid_unq UNIQUE ( payment_method_srcid )
  );