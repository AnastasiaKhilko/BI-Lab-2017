CREATE TABLE promotion_types (
    promotion_type_id          NUMBER(10) NOT NULL,
    promotion_type             VARCHAR2(40 BYTE) NOT NULL,
    promotion_description      VARCHAR2(40 BYTE) NOT NULL,
    promotion_price            NUMBER(10),
    price_decreasing_percent   NUMBER(10),
    free_unit_amount           NUMBER(10),
    CONSTRAINT promotion_type_id_pk PRIMARY KEY ( promotion_type_id ) ENABLE
);