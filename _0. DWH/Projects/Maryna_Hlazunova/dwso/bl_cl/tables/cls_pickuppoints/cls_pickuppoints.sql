/**===============================================*\
Name...............:   Cleansing table cls_pickuppoints BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE cls_pickuppoints;
--**********************************************

CREATE TABLE cls_pickuppoints (
    nat_code         VARCHAR2(3),
    point_location   VARCHAR2(50),
    point_address    VARCHAR2(250)
);

--**********************************************

--SELECT * FROM cls_pickuppoints;