--CE_ORDERS.
DROP TABLE ce_orders;
CREATE TABLE ce_orders
  (
    order_id           NUMBER(38) NOT NULL,
    order_dt           DATE NOT NULL,
    seller_id          NUMBER(38) NOT NULL,
    customer_id        NUMBER(38) NOT NULL,
    payment_method_id  NUMBER(38) NOT NULL,
    delivery_method_id NUMBER(38) NOT NULL,
    product_info_id    NUMBER(38) NOT NULL,
    sum_of_payment     NUMBER(38,2) NOT NULL,
    insert_dt          DATE DEFAULT SYSDATE,
    CONSTRAINT rc_seller_id_fk FOREIGN KEY ( seller_id ) REFERENCES ce_sellers ( seller_id ),
    CONSTRAINT rc_customer_id_fk FOREIGN KEY ( customer_id ) REFERENCES ce_customers ( customer_id ),
    CONSTRAINT payment_method_id_fk FOREIGN KEY ( payment_method_id ) REFERENCES ce_payment_methods ( payment_method_id ),
    CONSTRAINT delivery_method_id_fk FOREIGN KEY ( delivery_method_id ) REFERENCES ce_delivery_methods ( delivery_method_id ),
    CONSTRAINT product_info_id_fk FOREIGN KEY ( product_info_id ) REFERENCES ce_product_info ( product_info_id )
  );