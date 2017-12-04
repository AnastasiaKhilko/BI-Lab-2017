/**===============================================*\
Name...............:   Cleansing table cls_brands BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE cls_brands;
--**********************************************

CREATE TABLE cls_brands (
    nat_code     VARCHAR2(6 CHAR),
    brand_desc   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from cls_brands;