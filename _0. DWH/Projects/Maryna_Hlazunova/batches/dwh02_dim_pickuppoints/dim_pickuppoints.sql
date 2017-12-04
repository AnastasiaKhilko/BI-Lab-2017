/**===============================================*\
Name...............:   Cleansing table dim_pickuppoints BL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP TABLE dim_pickuppoints;
--**********************************************

CREATE TABLE dim_pickuppoints (
    pickuppoint_surrid   NUMBER(3) PRIMARY KEY,
    pickuppoint_srcid    NUMBER(3) NOT NULL,
    address              VARCHAR2(250 BYTE) NOT NULL,
    loc_srcid            NUMBER(6,0) NOT NULL,
    location_name        VARCHAR2(100 CHAR) NOT NULL,
    loc_type_srcid       NUMBER(2) NOT NULL,
    loc_type_short       VARCHAR2(10 CHAR) NOT NULL,
    loc_type_full        VARCHAR2(25 CHAR) NOT NULL,
    dis_srcid            NUMBER(3,0) NOT NULL,
    district             VARCHAR2(100 CHAR) NOT NULL,
    reg_srcid            NUMBER(2,0) NOT NULL,
    region               VARCHAR2(100 CHAR) NOT NULL,
    ta_insert_dt         DATE NOT NULL,
    ta_update_dt         DATE NOT NULL
);
--**********************************************
--select * from dim_pickuppoints;