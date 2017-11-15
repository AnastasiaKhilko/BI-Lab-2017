CREATE TABLE ce_receipts (
    receipt_id             NUMBER(10) NOT NULL,
    receipt_dt             DATE NOT NULL,
    store_srcid            NUMBER(10) NOT NULL,
    employee_id            NUMBER(10) NOT NULL,
    customer_srcid         NUMBER(10) NOT NULL,
    payment_method_srcid   NUMBER(10) NOT NULL,
    currency_id            VARCHAR2(40 BYTE) NOT NULL,
    receipt_sum            NUMBER(10) NOT NULL,
    insert_dt              DATE NOT NULL,
    CONSTRAINT receipt_id_pk PRIMARY KEY ( receipt_id ),
    CONSTRAINT rc_store_srcid_fk FOREIGN KEY ( store_srcid )
        REFERENCES ce_stores ( store_srcid ),
    CONSTRAINT rc_employee_id_fk FOREIGN KEY ( employee_id )
        REFERENCES ce_employees ( employee_id ),
    CONSTRAINT rc_customer_srcid_fk FOREIGN KEY ( customer_srcid )
        REFERENCES ce_customers ( customer_srcid ),
    CONSTRAINT payment_method_srcid_fk FOREIGN KEY ( payment_method_srcid )
        REFERENCES ce_payment_methods ( payment_method_srcid ),
    CONSTRAINT currency_id_fk FOREIGN KEY ( currency_id )
        REFERENCES ce_currencies ( currency_id )
);