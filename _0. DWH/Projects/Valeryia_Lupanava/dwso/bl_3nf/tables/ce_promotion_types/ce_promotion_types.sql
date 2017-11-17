CREATE TABLE ce_promotion_types (
    promotion_type_srcid       NUMBER(10) NOT NULL,
    promotion_type             VARCHAR2(40 BYTE) NOT NULL,
    promotion_description      VARCHAR2(40 BYTE) NOT NULL,
    promotion_price            NUMBER(10) DEFAULT '-99',
    price_decreasing_percent   NUMBER(10) DEFAULT '-99',
    free_unit_amount           NUMBER(10) DEFAULT '-99',
    start_dt                   DATE NOT NULL,
    end_dt                     DATE NOT NULL,
    is_active                  VARCHAR2(4) NOT NULL,
    CONSTRAINT promotion_type_srcid_pk PRIMARY KEY ( promotion_type_srcid ) ENABLE
);