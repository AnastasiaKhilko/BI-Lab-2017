CREATE TABLE fact_product_balances (
    date_id                 NUMBER(10) NOT NULL,
    product_details_id      NUMBER(10) NOT NULL,
    manager_id              NUMBER(10) NOT NULL,
    store_id                NUMBER(10) NOT NULL,
    stock_value             NUMBER(10) NOT NULL,
    total_product_balance   NUMBER(10) NOT NULL,
    CONSTRAINT date_bl_id_fk FOREIGN KEY ( date_id )
        REFERENCES dim_date ( date_id ),
    CONSTRAINT product_bl_id_fk FOREIGN KEY ( product_details_id )
        REFERENCES dim_products ( product_details_id ),
    CONSTRAINT store_bl_id_fk FOREIGN KEY ( store_id )
        REFERENCES dim_stores ( store_id )
);