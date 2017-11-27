BEGIN
  pkg_drop.drop_proc(object_name => 'ce_receipts', object_type => 'table');
END;

CREATE TABLE ce_receipts
  (
    receipt_id           NUMBER(10) NOT NULL,
    receipt_srcid        NUMBER(10) NOT NULL,
    receipt_number       NUMBER(38) NOT NULL,
    receipt_dt           DATE NOT NULL,
    store_srcid          NUMBER(10) NOT NULL,
    employee_srcid       NUMBER(10) NOT NULL,
    customer_srcid       NUMBER(10) NOT NULL,
    payment_method_srcid NUMBER(10) NOT NULL,
    product_detail_srcid NUMBER(10) NOT NULL,
    receipt_sum_usd      NUMBER(10,2) NOT NULL,
    insert_dt            DATE DEFAULT SYSDATE,
    CONSTRAINT receipt_id_pk PRIMARY KEY ( receipt_id ),
    CONSTRAINT receipt_srcid_unq UNIQUE ( receipt_srcid ),
    CONSTRAINT rc_store_srcid_fk FOREIGN KEY ( store_srcid ) 
    REFERENCES ce_stores ( store_srcid ),
    CONSTRAINT rc_employee_srcid_fk FOREIGN KEY ( employee_srcid ) 
    REFERENCES ce_employees ( employee_srcid ),
    CONSTRAINT rc_customer_srcid_fk FOREIGN KEY ( customer_srcid ) 
    REFERENCES ce_customers ( customer_srcid ),
    CONSTRAINT payment_method_srcid_fk FOREIGN KEY ( payment_method_srcid ) 
    REFERENCES ce_payment_methods ( payment_method_srcid ),
    CONSTRAINT product_detail_srcid_fk FOREIGN KEY ( product_detail_srcid ) 
    REFERENCES ce_product_details ( product_details_srcid )
  );