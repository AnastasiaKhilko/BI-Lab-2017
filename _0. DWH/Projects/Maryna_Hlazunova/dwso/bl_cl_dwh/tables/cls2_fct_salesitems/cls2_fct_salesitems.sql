/**===============================================*\
Name...............:   Cleansing table cls2_fct_salesitems BL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   02-Dec-2017
\*=============================================== */
DROP TABLE cls2_fct_salesitems;
--**********************************************

CREATE TABLE cls2_fct_salesitems (
    order_id           NUMBER(15) NOT NULL,
    order_date         DATE NOT NULL,
    customer_id        NUMBER(12,0) NOT NULL,
    product_id         NUMBER(10) NOT NULL,
    pay_id             NUMBER(2,0) NOT NULL,
    del_id             NUMBER(2,0) NOT NULL,
    pickuppoint_id     NUMBER(2,0) NOT NULL,
    fct_quantity       NUMBER(20) NOT NULL,
    fct_item_sum       NUMBER(35,2) NOT NULL,
    fct_discount_sum   NUMBER(35,2) NOT NULL,
    fct_total_sum      NUMBER(35,2) NOT NULL
);

--**********************************************
--select * from cls2_products;