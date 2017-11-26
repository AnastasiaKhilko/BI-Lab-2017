BEGIN
  pkg_drop.drop_proc(object_name => 'fct_retail_sales_dd', object_type => 'table');
END;

CREATE TABLE fct_retail_sales_dd (
    sale_id                  NUMBER(38) NOT NULL,
    receipt_id               VARCHAR2(100 BYTE) NOT NULL,
    event_dt                 DATE NOT NULL,
    product_surr_id          NUMBER(38),
    employee_surr_id         NUMBER(38),
    customer_surr_id         NUMBER(38),
    store_surr_id            NUMBER(38),
    payment_method_surr_id   NUMBER(38),
    tot_sale_sum             NUMBER(38),
    tot_sale_amount          NUMBER(38),
    insert_dt                DATE NOT NULL,
    update_dt                DATE NOT NULL,
    CONSTRAINT product_surr_id_fk FOREIGN KEY (product_surr_id)
    REFERENCES dim_products_scd (product_surr_id),
    CONSTRAINT employee_surr_id_fk FOREIGN KEY (employee_surr_id)
    REFERENCES dim_employees_scd (employee_surr_id),
    CONSTRAINT customer_surr_id_fk FOREIGN KEY (customer_surr_id)
    REFERENCES dim_customers_scd (customer_surr_id),
    CONSTRAINT payment_method_surr_id_fk FOREIGN KEY (payment_method_surr_id)
    REFERENCES dim_payment_methods_scd (payment_method_id),
    CONSTRAINT store_id_fk FOREIGN KEY (store_surr_id)
    REFERENCES dim_stores_scd (store_surr_id),
    CONSTRAINT event_dt_fk FOREIGN KEY (event_dt)
    REFERENCES dim_time_day (date_dt)
);