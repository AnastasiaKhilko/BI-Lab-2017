CREATE TABLE ce_product_types (
    product_type_srcid   NUMBER(10) NOT NULL,
    product_type         VARCHAR2(10 BYTE) NOT NULL,
    start_dt             DATE NOT NULL,
    end_dt               DATE NOT NULL,
    is_active            VARCHAR2(4) NOT NULL,
    CONSTRAINT product_type_srcid_pk PRIMARY KEY ( product_type_srcid ) ENABLE
);