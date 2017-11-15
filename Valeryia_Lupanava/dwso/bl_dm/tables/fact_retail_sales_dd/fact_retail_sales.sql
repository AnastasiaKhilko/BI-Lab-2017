CREATE TABLE fct_retail_sales_dd (
    sale_id                  NUMBER(10) NOT NULL,
    receipt_id               NUMBER(10) NOT NULL,
    event_dt                 DATE NOT NULL,
    product_surr_id          NUMBER(10) NOT NULL,
    employee_surr_id         NUMBER(10) NOT NULL,
    customer_surr_id         NUMBER(10) NOT NULL,
    store_id                 NUMBER(10) NOT NULL,
    payment_method_surr_id   NUMBER(10) NOT NULL,
    promotion_surr_id        NUMBER(10) DEFAULT '-99',
    currency_id              NUMBER(10) NOT NULL,
    tot_sale_sum             NUMBER(10) NOT NULL,
    tot_sale_amount          NUMBER(10) NOT NULL,
    insert_dt                DATE NOT NULL,
    update_dt                DATE NOT NULL,
    CONSTRAINT sl_date_id_fk FOREIGN KEY ( event_dt )
        REFERENCES dim_time_day ( date_dt ),
    CONSTRAINT sl_product_surr_id_fk FOREIGN KEY ( product_surr_id )
        REFERENCES dim_products_scd ( product_surr_id ),
    CONSTRAINT sl_customer_surr_id_fk FOREIGN KEY ( customer_surr_id )
        REFERENCES dim_customers_scd ( customer_surr_id ),
    CONSTRAINT sl_store_id_fk FOREIGN KEY ( store_id )
        REFERENCES dim_stores ( store_id ),
    CONSTRAINT sl_employee_surr_id_fk FOREIGN KEY ( employee_surr_id )
        REFERENCES dim_employees_scd ( employee_surr_id ),
    CONSTRAINT sl_payment_method_surr_id_fk FOREIGN KEY ( payment_method_surr_id )
        REFERENCES dim_payment_methods_scd ( payment_method_surr_id ),
    CONSTRAINT sl_promotion_surr_id_fk FOREIGN KEY ( promotion_surr_id )
        REFERENCES dim_promotions_scd ( promotion_surr_id )
);