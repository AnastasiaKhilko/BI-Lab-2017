CREATE TABLE dim_promotions_scd (
    promotion_surr_id          NUMBER(10) NOT NULL,
    promotion_id               VARCHAR2(40 BYTE) NOT NULL,
    promotion_desc             VARCHAR2(40 BYTE) NOT NULL,
    promotion_type_id          NUMBER(10) NOT NULL,
    promotion_type             VARCHAR2(40 BYTE) NOT NULL,
    promotion_price            NUMBER(10) DEFAULT 0,
    price_decreasing_percent   NUMBER(10) DEFAULT 0,
    free_unit_amount           NUMBER(10) DEFAULT 0,
    start_dt                   DATE NOT NULL,
    end_dt                     DATE NOT NULL,
    is_active                  VARCHAR2(4) NOT NULL,
    CONSTRAINT promotion_surr_id_pk PRIMARY KEY ( promotion_surr_id )
);