CREATE TABLE product_details (
    product_details_id   NUMBER(10) NOT NULL,
    product_id           NUMBER(10) NOT NULL,
    height               VARCHAR2(10 BYTE),
    hip_girth            NUMBER(10),
    bra_size_id          NUMBER(10),
    panties_size_id      NUMBER(10),
    color                VARCHAR2(40 BYTE),
    price                NUMBER(10),
    product_balance      NUMBER(10),
    CONSTRAINT product_details_id_pk PRIMARY KEY ( product_details_id ),
    CONSTRAINT product_id_fk FOREIGN KEY ( product_id )
        REFERENCES products ( product_id ),
    CONSTRAINT bra_size_id_fk FOREIGN KEY ( bra_size_id )
        REFERENCES bra_size_grid ( bra_size_id ),
    CONSTRAINT panties_size_id_fk FOREIGN KEY ( panties_size_id )
        REFERENCES panties_size_grid ( panties_size_id )
);