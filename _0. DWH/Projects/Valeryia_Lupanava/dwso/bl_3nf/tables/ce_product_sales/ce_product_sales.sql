BEGIN
  pkg_drop.drop_proc(object_name => 'ce_product_sales', object_type => 'table');
END;

CREATE TABLE ce_product_sales
  (
    sale_id               NUMBER(10) NOT NULL,
    receipt_srcid         NUMBER(10) NOT NULL,
    product_details_srcid NUMBER(10) NOT NULL,
    sale_sum_usd          NUMBER(10,2) NOT NULL,
    sale_amount           NUMBER(10) NOT NULL,
    insert_dt             DATE NOT NULL,
    CONSTRAINT sale_id_pk PRIMARY KEY ( sale_id ),
    CONSTRAINT receipt_srcid_fk FOREIGN KEY ( receipt_srcid ) 
    REFERENCES ce_receipts ( receipt_srcid ),
    CONSTRAINT product_details_srcid_fk FOREIGN KEY ( product_details_srcid ) 
    REFERENCES ce_product_details ( product_details_srcid )
  );