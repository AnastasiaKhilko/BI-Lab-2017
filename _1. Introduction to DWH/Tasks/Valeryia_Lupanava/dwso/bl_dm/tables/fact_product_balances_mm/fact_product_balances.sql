CREATE TABLE fct_product_balances_mm (
    event_dt              DATE NOT NULL,
    product_surr_id       NUMBER(10) NOT NULL,
    manager_surr_id       NUMBER(10) NOT NULL,
    store_id              NUMBER(10) NOT NULL,
    tot_stock_value       NUMBER(10) NOT NULL,
    tot_product_balance   NUMBER(10) NOT NULL,
    insert_dt             DATE NOT NULL,
    update_dt             DATE NOT NULL,
    CONSTRAINT bl_date_dt_fk FOREIGN KEY ( event_dt )
        REFERENCES dim_time_day ( date_dt ),
    CONSTRAINT bl_product_surr_id_fk FOREIGN KEY ( product_surr_id )
        REFERENCES dim_products_scd ( product_surr_id ),
    CONSTRAINT bl_store_id_fk FOREIGN KEY ( store_id )
        REFERENCES dim_stores ( store_id )
);