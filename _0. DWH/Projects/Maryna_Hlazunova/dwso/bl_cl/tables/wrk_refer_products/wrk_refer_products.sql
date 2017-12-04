/**===============================================*\
Name...............:   Cleansing table wrk_refer_products BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE wrk_refer_products;
--**********************************************

CREATE TABLE wrk_refer_products (
    type_code     VARCHAR2(5 CHAR),
    type          VARCHAR2(100 CHAR),
    subcat_code   VARCHAR2(5 CHAR),
    subcategory   VARCHAR2(100 CHAR),
    cat_code      VARCHAR2(3 CHAR),
    category      VARCHAR2(100 CHAR)
);
--**********************************************
-- select * from wrk_refer_products;