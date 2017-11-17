CREATE TABLE dim_payment_methods_scd (
    payment_method_surr_id   NUMBER(10) NOT NULL,
    payment_method_id        VARCHAR2(40 BYTE) NOT NULL,
    payment_method_desc      VARCHAR2(40 BYTE) NOT NULL,
    bank_name                VARCHAR2(40 BYTE),
    start_dt                 DATE NOT NULL,
    end_dt                   DATE NOT NULL,
    is_active                VARCHAR2(4) NOT NULL,
    CONSTRAINT payment_method_surr_id_pk PRIMARY KEY ( payment_method_surr_id )
);