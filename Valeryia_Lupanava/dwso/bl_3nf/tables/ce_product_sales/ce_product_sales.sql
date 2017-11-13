CREATE TABLE product_sales (
    sale_id              NUMBER(10) NOT NULL,
    receipt_id           NUMBER(10) NOT NULL,
    product_details_id   NUMBER(10) NOT NULL,
    sale_sum             NUMBER(10) NOT NULL,
    sale_amount          NUMBER(10) NOT NULL,
    CONSTRAINT sale_id_pk PRIMARY KEY ( sale_id ),
    CONSTRAINT receipt_id_fk FOREIGN KEY ( receipt_id )
        REFERENCES receipts ( receipt_id ),
    CONSTRAINT product_details_id_fk FOREIGN KEY ( product_details_id )
        REFERENCES product_details ( product_details_id )
);