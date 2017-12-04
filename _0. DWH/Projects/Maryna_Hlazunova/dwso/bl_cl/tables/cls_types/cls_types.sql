/**===============================================*\
Name...............:   Cleansing table cls_types BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   28-Nov-2017
\*=============================================== */
DROP TABLE cls_types;
--**********************************************

CREATE TABLE cls_types (
    type_code     VARCHAR2(5 CHAR),
    type_name     VARCHAR2(100 CHAR),
    subcat_code   VARCHAR2(5 CHAR)
);

--**********************************************

--SELECT * FROM cls_types;