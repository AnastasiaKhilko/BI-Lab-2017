/**===============================================*\
Name...............:   Cleansing table wrk_products BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   29-Nov-2017
\*=============================================== */
DROP TABLE wrk_products;
--**********************************************

CREATE TABLE wrk_products (
    prod_code       VARCHAR2(8 CHAR),
    vendor_code     VARCHAR2(8 CHAR),
    product_name    VARCHAR2(100 CHAR),
    product_color   VARCHAR2(20 CHAR),
    brand           VARCHAR2(5 CHAR),
    type            VARCHAR2(4 CHAR)
);
--**********************************************
-- select * from wrk_products;