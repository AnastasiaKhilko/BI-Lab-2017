BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_payment_methods', Object_Type => 'table');
END;

CREATE TABLE ce_payment_methods (
    payment_method_srcid   NUMBER(10) NOT NULL,
    payment_method_name    VARCHAR2(40 BYTE) NOT NULL,
    bank_name              VARCHAR2(40 BYTE) DEFAULT '-99',
    CONSTRAINT payment_method_srcid_pk PRIMARY KEY ( payment_method_srcid )
);