/**===============================================*\
Name...............:   Cleansing table cls_deliveries BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE cls_deliveries;
--**********************************************

CREATE TABLE cls_deliveries (
    nat_code   VARCHAR2(3 CHAR),
    delivery   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from cls_deliveries;