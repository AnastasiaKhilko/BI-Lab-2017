CREATE TABLE product_types (
    product_type_id   NUMBER(10) NOT NULL,
    product_type      VARCHAR2(10 BYTE),
    CONSTRAINT product_type_id_pk PRIMARY KEY ( product_type_id ) ENABLE
);