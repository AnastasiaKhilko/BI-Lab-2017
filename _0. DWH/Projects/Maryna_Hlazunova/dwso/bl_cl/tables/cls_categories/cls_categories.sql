/**===============================================*\
Name...............:   Cleansing table cls_categories BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   27-Nov-2017
\*=============================================== */
DROP TABLE cls_categories;
--**********************************************

CREATE TABLE cls_categories (
    cat_code   VARCHAR2(3 CHAR),
    category   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from cls_categories;