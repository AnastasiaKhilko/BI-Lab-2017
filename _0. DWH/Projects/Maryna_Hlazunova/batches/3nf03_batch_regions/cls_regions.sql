/**===============================================*\
Name...............:   Cleansing table cls_regions BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE cls_regions;
--==============================================================

CREATE TABLE cls_regions (
    reg_code   VARCHAR2(3 CHAR),
    region     VARCHAR2(100 CHAR)
);
--**********************************************

--SELECT * FROM cls_regions;