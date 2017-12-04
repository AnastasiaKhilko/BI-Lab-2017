/**===============================================*\
Name...............:   Cleansing table cls_products BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   29-Nov-2017
\*=============================================== */
DROP TABLE cls_products;
--**********************************************

CREATE TABLE cls_products (
    prod_code      VARCHAR2(8 CHAR),
    vendor_code    VARCHAR2(8 CHAR),
    product_name   VARCHAR2(100 CHAR),
    color_id       NUMBER(3),
    brand_id       NUMBER(6),
    type_id        NUMBER(4),
    start_dt       DATE,
    end_dt         DATE,
    is_active      VARCHAR2(1 CHAR)
);
--**********************************************
-- select * from cls_products;