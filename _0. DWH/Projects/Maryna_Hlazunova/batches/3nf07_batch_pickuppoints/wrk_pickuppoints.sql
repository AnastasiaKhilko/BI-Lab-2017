/**===============================================*\
Name...............:   Cleansing table wrk_pickuppoints BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE wrk_pickuppoints;
--**********************************************

CREATE TABLE wrk_pickuppoints (
    nat_code   VARCHAR2(3 CHAR),
    address    VARCHAR2(300 CHAR)
);
--**********************************************

-- SELECT * FROM wrk_pickuppoints;