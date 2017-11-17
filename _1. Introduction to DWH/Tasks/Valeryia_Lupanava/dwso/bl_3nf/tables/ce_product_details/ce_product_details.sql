CREATE TABLE ce_product_details (
    product_details_srcid   NUMBER(10) NOT NULL,
    product_srcid           NUMBER(10) NOT NULL,
    height                  VARCHAR2(10 BYTE) DEFAULT '-99',
    hip_girth               NUMBER(10) DEFAULT '-99',
    bra_size_srcid          NUMBER(10) DEFAULT '-99',
    panties_size_srcid      NUMBER(10) DEFAULT '-99',
    color                   VARCHAR2(40 BYTE) DEFAULT '-99',
    price                   NUMBER(10) DEFAULT '-99',
    product_balance         NUMBER(10) DEFAULT '-99',
    insert_dt               DATE NOT NULL,
    update_dt               DATE,
    CONSTRAINT product_details_srcid_pk PRIMARY KEY ( product_details_srcid ),
    CONSTRAINT product_srcid_fk FOREIGN KEY ( product_srcid )
        REFERENCES ce_products ( product_srcid ),
    CONSTRAINT bra_size_srcid_fk FOREIGN KEY ( bra_size_srcid )
        REFERENCES ce_bra_size_grid ( bra_size_srcid ),
    CONSTRAINT panties_size_srcid_fk FOREIGN KEY ( panties_size_srcid )
        REFERENCES ce_panties_size_grid ( panties_size_srcid )
);