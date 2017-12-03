DROP TABLE fct_orders;
CREATE TABLE fct_orders
  (
    sale_id            NUMBER(38) NOT NULL,
    order_id           NUMBER(38) NOT NULL,
    event_dt           DATE NOT NULL,
    seller_surr_id     NUMBER(38) NOT NULL,
    customer_surr_id   NUMBER(38) NOT NULL,
    payment_method_id  NUMBER(38) NOT NULL,
    delivery_method_id NUMBER(38) NOT NULL,
    product_surr_id    NUMBER(38) NOT NULL,
    total_cost         NUMBER(38) NOT NULL,
    COUNT              NUMBER(38) NOT NULL,
    insert_dt          DATE NOT NULL,
    update_dt          DATE NOT NULL,
    CONSTRAINT product_surr_id_fk FOREIGN KEY (product_surr_id) REFERENCES dim_products (product_surr_id),
    CONSTRAINT seller_surr_id_fk FOREIGN KEY (seller_surr_id) REFERENCES dim_sellers (seller_surr_id),
    CONSTRAINT customer_surr_id_fk FOREIGN KEY (customer_surr_id) REFERENCES dim_customers(customer_surr_id),
    CONSTRAINT payment_method_surr_id_fk FOREIGN KEY (payment_method_id) REFERENCES dim_payment_methods(payment_method_id),
    CONSTRAINT delivery_method_surr_id_fk FOREIGN KEY (delivery_method_id) REFERENCES dim_delivery_methods(delivery_method_id),
    CONSTRAINT event_dt_fk FOREIGN KEY (event_dt) REFERENCES dim_date (date_dt)
  );