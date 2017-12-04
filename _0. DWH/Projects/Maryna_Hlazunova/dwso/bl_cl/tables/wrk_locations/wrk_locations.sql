/**===============================================*\
Name...............:   Cleansing table wrk_deliveries BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE wrk_locations;
--**********************************************

CREATE TABLE wrk_locations (
    loc_code        VARCHAR2(6 CHAR),
    location_type   VARCHAR2(5 CHAR),
    location_name   VARCHAR2(100 CHAR),
    dis_code        VARCHAR2(4 CHAR),
    district        VARCHAR2(100 CHAR),
    reg_code        VARCHAR2(3 CHAR),
    region          VARCHAR2(100 CHAR)
);
--**********************************************

-- SELECT * FROM wrk_locations;