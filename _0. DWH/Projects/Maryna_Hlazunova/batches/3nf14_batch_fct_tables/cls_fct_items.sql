/**===============================================*\
Name...............:   Cleansing table CLS_FCT_ITEMS BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE cls_fct_items;
--**********************************************

CREATE TABLE cls_fct_items (
    order_id     NUMBER(15,0),
    product_id   NUMBER(10),
    price        NUMBER,
    quantity     NUMBER(1),
    discount     NUMBER(2)
);
--**********************************************
--select * from cls_fct_items;