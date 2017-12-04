/**===============================================*\
Name...............:   Cleansing table wrk_brands BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE wrk_brands;
--**********************************************

CREATE TABLE wrk_brands (
    nat_code     VARCHAR2(6 CHAR),
    brand_desc   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from wrk_brands;