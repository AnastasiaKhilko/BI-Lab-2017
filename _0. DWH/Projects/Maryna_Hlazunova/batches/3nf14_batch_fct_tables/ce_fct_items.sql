/**===============================================*\
Name...............:   Normalized table ce_fct_items 3NF layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP TABLE ce_fct_items;
--**********************************************

CREATE TABLE ce_fct_items (
    item_id      NUMBER(20,0) PRIMARY KEY,
    order_id     NUMBER(15,0),
    product_id   NUMBER(10),
    price        NUMBER,
    quantity     NUMBER(1),
    discount     NUMBER(2),
    insert_dt    DATE,
    CONSTRAINT fk_order_id FOREIGN KEY ( order_id )
        REFERENCES ce_fct_orders ( order_id ),
    CONSTRAINT fk_product_id FOREIGN KEY ( product_id )
        REFERENCES ce_products ( prod_id )
);
--**********************************************

-- SELECT  *  FROM    ce_fct_items;
--SELECT ORDER_ID,PRODUCT_ID,PRICE,QUANTITY,DISCOUNT FROM CLS_FCT_ITEMS ;