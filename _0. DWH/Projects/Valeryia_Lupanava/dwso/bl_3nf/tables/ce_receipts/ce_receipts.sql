BEGIN
  pkg_drop.DROP_Proc(Object_Name => 'ce_receipts', Object_Type => 'table');
END;

CREATE TABLE ce_receipts (
    receipt_id             NUMBER(10) NOT NULL,
    receipt_dt             DATE NOT NULL,
    store_srcid            NUMBER(10) NOT NULL,
    employee_id            NUMBER(10) NOT NULL,
    customer_srcid         NUMBER(10) NOT NULL,
    payment_method_srcid   NUMBER(10) NOT NULL,
    receipt_sum_usd        NUMBER(10,2) NOT NULL,
    insert_dt              DATE NOT NULL,
    CONSTRAINT receipt_id_pk PRIMARY KEY ( receipt_id ),
    CONSTRAINT rc_store_srcid_fk FOREIGN KEY ( store_srcid )
        REFERENCES ce_stores ( store_srcid ),
    CONSTRAINT rc_employee_id_fk FOREIGN KEY ( employee_id )
        REFERENCES ce_employees ( employee_id ),
    CONSTRAINT rc_customer_srcid_fk FOREIGN KEY ( customer_srcid )
        REFERENCES ce_customers ( customer_srcid ),
    CONSTRAINT payment_method_srcid_fk FOREIGN KEY ( payment_method_srcid )
        REFERENCES ce_payment_methods ( payment_method_srcid )
);