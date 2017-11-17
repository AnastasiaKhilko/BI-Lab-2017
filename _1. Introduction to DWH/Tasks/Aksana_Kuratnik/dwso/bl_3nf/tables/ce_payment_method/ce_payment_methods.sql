CREATE TABLE payment_methods (
    payment_method_id     NUMBER(10) NOT NULL,
    payment_method_name   VARCHAR2(40 BYTE) NOT NULL,
    bank_name             VARCHAR2(40 BYTE),
    CONSTRAINT payment_method_id_pk PRIMARY KEY ( payment_method_id )
);
