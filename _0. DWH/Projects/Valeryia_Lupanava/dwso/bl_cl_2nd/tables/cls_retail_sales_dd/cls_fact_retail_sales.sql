BEGIN
  pkg_drop.drop_proc(object_name => 'cls_fct_retail_sales_dd', object_type => 'table');
END;

CREATE TABLE cls_fct_retail_sales_dd (
    sale_id                  NUMBER(38) NOT NULL,
    receipt_id               VARCHAR2(100 BYTE) NOT NULL,
    event_dt                 DATE NOT NULL,
    product_surr_id          NUMBER(38) NOT NULL,
    employee_surr_id         NUMBER(38) NOT NULL,
    customer_surr_id         NUMBER(38) NOT NULL,
    store_id                 NUMBER(38) NOT NULL,
    payment_method_surr_id   NUMBER(38) NOT NULL,
    tot_sale_sum             NUMBER(38) NOT NULL,
    tot_sale_amount          NUMBER(38) NOT NULL,
    insert_dt                DATE NOT NULL,
    update_dt                DATE NOT NULL
);