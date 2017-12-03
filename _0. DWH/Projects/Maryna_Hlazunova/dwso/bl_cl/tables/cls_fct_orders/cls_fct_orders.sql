/**===============================================*\
Name...............:   Cleansing table cls_fct_orders BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
DROP TABLE cls_fct_orders;
--**********************************************

CREATE TABLE cls_fct_orders (
    order_code   VARCHAR2(15),
    order_date   DATE,
    cust_id      NUMBER(12,0),
    del_id       NUMBER(2,0),
    pay_id       NUMBER(2,0),
    point_id     NUMBER(3,0)
);
--**********************************************
--select * from cls_fct_orders;