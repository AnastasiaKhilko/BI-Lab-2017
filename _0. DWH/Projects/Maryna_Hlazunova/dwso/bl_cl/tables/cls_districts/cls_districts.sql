/**===============================================*\
Name...............:   Cleansing table cls_districts BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE cls_districts;
--==============================================================

CREATE TABLE cls_districts (
    dis_code   VARCHAR2(4 CHAR),
    district   VARCHAR2(100),
    reg_code   VARCHAR2(3 CHAR)
);
--**********************************************

--SELECT * FROM cls_districts;