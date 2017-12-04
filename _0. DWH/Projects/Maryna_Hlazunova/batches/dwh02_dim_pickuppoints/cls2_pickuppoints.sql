/**===============================================*\
Name...............:   Cleansing table cls2_pickuppoints BL_CL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP TABLE cls2_pickuppoints;
--**********************************************

CREATE TABLE cls2_pickuppoints (
    pickuppoint_srcid   NUMBER(3) NOT NULL,
    address             VARCHAR2(250 BYTE) NOT NULL,
    loc_srcid           NUMBER(6,0) NOT NULL,
    location_name       VARCHAR2(100 CHAR) NOT NULL,
    loc_type_srcid      NUMBER(2) NOT NULL,
    loc_type_short      VARCHAR2(10 CHAR) NOT NULL,
    loc_type_full       VARCHAR2(25 CHAR) NOT NULL,
    dis_srcid           NUMBER(3,0) NOT NULL,
    district            VARCHAR2(100 CHAR) NOT NULL,
    reg_srcid           NUMBER(2,0) NOT NULL,
    region              VARCHAR2(100 CHAR) NOT NULL
);
--**********************************************
--select * from cls2_pickuppoints;