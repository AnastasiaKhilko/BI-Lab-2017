CREATE TABLE ce_product_sales (
    sale_srcid              NUMBER(10) NOT NULL,
    receipt_id              NUMBER(10) NOT NULL,
    product_details_srcid   NUMBER(10) NOT NULL,
    sale_sum                NUMBER(10) NOT NULL,
    sale_amount             NUMBER(10) NOT NULL,
    insert_dt               DATE NOT NULL,
    CONSTRAINT sale_srcid_pk PRIMARY KEY ( sale_srcid ),
    CONSTRAINT receipt_id_fk FOREIGN KEY ( receipt_id )
        REFERENCES ce_receipts ( receipt_id ),
    CONSTRAINT product_details_srcid_fk FOREIGN KEY ( product_details_srcid )
        REFERENCES ce_product_details ( product_details_srcid )
);