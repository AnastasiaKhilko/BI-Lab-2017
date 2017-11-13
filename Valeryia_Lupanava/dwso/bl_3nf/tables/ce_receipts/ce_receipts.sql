CREATE TABLE receipts (
    receipt_id          NUMBER(10) NOT NULL,
    receipt_date        DATE NOT NULL,
    store_id            NUMBER(10) NOT NULL,
    employee_id         NUMBER(10) NOT NULL,
    customer_id         NUMBER(10) NOT NULL,
    payment_method_id   NUMBER(10) NOT NULL,
    currency_id         VARCHAR2(40 BYTE) NOT NULL,
    receipt_sum         NUMBER(10) NOT NULL,
    CONSTRAINT receipt_id_pk PRIMARY KEY ( receipt_id ),
    CONSTRAINT store_rc_id_fk FOREIGN KEY ( store_id )
        REFERENCES stores ( store_id ),
    CONSTRAINT employee_rc_id_fk FOREIGN KEY ( employee_id )
        REFERENCES employees ( employee_id ),
    CONSTRAINT customer_rc_id_fk FOREIGN KEY ( customer_id )
        REFERENCES customers ( customer_id ),
    CONSTRAINT payment_method_id_fk FOREIGN KEY ( payment_method_id )
        REFERENCES payment_methods ( payment_method_id ),
    CONSTRAINT currency_id_fk FOREIGN KEY ( currency_id )
        REFERENCES currencies ( currency_id )
);