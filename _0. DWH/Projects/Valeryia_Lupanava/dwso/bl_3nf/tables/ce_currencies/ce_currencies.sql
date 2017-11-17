CREATE TABLE ce_currencies (
    currency_id     VARCHAR2(40 BYTE) NOT NULL,
    currency_name   VARCHAR2(40 BYTE) NOT NULL,
    CONSTRAINT currency_id_pk PRIMARY KEY ( currency_id )
);