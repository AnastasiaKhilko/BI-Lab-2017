/**===============================================*\
Name...............:   Cleansing table wrk_deliveries BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE wrk_deliveries;
--**********************************************

CREATE TABLE wrk_deliveries (
    nat_code   VARCHAR2(3 CHAR),
    delivery   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from wrk_deliveries;