/**===============================================*\
Name...............:   Cleansing table cls_categories BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE cls_subcategories;
--**********************************************

CREATE TABLE cls_subcategories (
    subcat_code   VARCHAR2(5 CHAR),
    subcategory   VARCHAR2(100 CHAR),
    cat_code      VARCHAR2(3 CHAR)
);
--**********************************************
--select * from cls_categories;