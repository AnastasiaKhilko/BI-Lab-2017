/**===============================================*\
Name...............:   Cleansing table dim_paydeliveries BL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP TABLE dim_paydeliveries;
--**********************************************

CREATE TABLE dim_paydeliveries (
    paydelivery_surrid   NUMBER(2) PRIMARY KEY,
    delivery_srcid       NUMBER(8) NOT NULL,
    delivery_desc        VARCHAR2(50) NOT NULL,
    payoption_srcid      NUMBER(3) NOT NULL,
    payoption_desc       VARCHAR2(50) NOT NULL,
    ta_insert_dt         DATE NOT NULL,
    ta_update_dt         DATE NOT NULL
);
--**********************************************
--select * from dim_paydeliveries;