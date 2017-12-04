/**===============================================*\
Name...............:   Cleansing table cls_localities BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE cls_localities;
--**********************************************

CREATE TABLE cls_localities (
    loc_code        VARCHAR2(6 CHAR),
    location_type   VARCHAR2(5 CHAR),
    location_name   VARCHAR2(100 CHAR),
    dis_code        VARCHAR2(4 CHAR),
    reg_code        VARCHAR2(3 CHAR)
);
--**********************************************

--SELECT * FROM cls_localities;