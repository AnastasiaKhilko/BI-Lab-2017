-- CLS_ORDERS.
DROP TABLE cls_orders;
CREATE TABLE cls_orders
  (
    order_id           NUMBER ( 38 ) NOT NULL,
    order_dt           DATE NOT NULL,
    seller_id        NUMBER ( 38 ) NOT NULL,
    customer_id        NUMBER ( 38 ) NOT NULL,
    payment_method_id  NUMBER ( 38 ) NOT NULL,
    delivery_method_id NUMBER ( 38 ) NOT NULL,
    product_info_id    NUMBER ( 38 ) NOT NULL,
    sum_of_payment      NUMBER ( 38 ) NOT NULL,
    insert_dt          DATE DEFAULT '31-DEC-1999'
  );