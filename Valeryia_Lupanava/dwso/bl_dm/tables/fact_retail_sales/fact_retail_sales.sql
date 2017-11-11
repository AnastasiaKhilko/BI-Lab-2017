CREATE TABLE fact_retail_sales (
    sale_id              NUMBER(10) NOT NULL,
    receipt_id           NUMBER(10) NOT NULL,
    date_id              NUMBER(10) NOT NULL,
    product_details_id   NUMBER(10) NOT NULL,
    employee_id          NUMBER(10) NOT NULL,
    customer_id          NUMBER(10),
    store_id             NUMBER(10) NOT NULL,
    payment_method_id    NUMBER(10) NOT NULL,
    promotion_id         NUMBER(10),
    currency_id          NUMBER(10) NOT NULL,
    sale_sum             NUMBER(10) NOT NULL,
    sale_amount          NUMBER(10) NOT NULL,
    CONSTRAINT date_id_fk FOREIGN KEY ( date_id )
        REFERENCES dim_date ( date_id ),
    CONSTRAINT product_id_fk FOREIGN KEY ( product_details_id )
        REFERENCES dim_products ( product_details_id ),
    CONSTRAINT customer_id_fk FOREIGN KEY ( customer_id )
        REFERENCES dim_customers ( customer_id ),
    CONSTRAINT store_id_fk FOREIGN KEY ( store_id )
        REFERENCES dim_stores ( store_id ),
    CONSTRAINT sales_employee_id_fk FOREIGN KEY ( employee_id )
        REFERENCES dim_employees ( employee_id ),
    CONSTRAINT payment_method_id_fk FOREIGN KEY ( payment_method_id )
        REFERENCES dim_payment_methods ( payment_method_id ),
    CONSTRAINT promotion_id_fk FOREIGN KEY ( promotion_id )
        REFERENCES dim_promotions ( promotion_id )
);