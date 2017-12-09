--CLS_FCT_ORDERS.
DROP TABLE cls_fct_orders;
CREATE TABLE cls_fct_orders
  (
    order_id                NUMBER(38) NOT NULL,
    order_dt                DATE NOT NULL,
    seller_surr_id          NUMBER(38) NOT NULL,
    customer_surr_id        NUMBER(38) NOT NULL,
    payment_method_surr_id  NUMBER(38) NOT NULL,
    delivery_method_surr_id NUMBER(38) NOT NULL,
    product_surr_id         NUMBER(38) NOT NULL,
    amount                  NUMBER(38) NOT NULL,
    sum_of_payment          NUMBER(38) NOT NULL,
    insert_dt               DATE NOT NULL,
    update_dt               DATE NOT NULL
  );