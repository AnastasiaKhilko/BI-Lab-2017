/**===============================================*\
Name...............:   Cleansing table cls2_paydeliveries BL_CL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP TABLE cls2_paydeliveries;
--**********************************************

CREATE TABLE cls2_paydeliveries (
    delivery_srcid    NUMBER(8) NOT NULL,
    delivery_desc     VARCHAR2(50) NOT NULL,
    payoption_srcid   NUMBER(3) NOT NULL,
    payoption_desc    VARCHAR2(50) NOT NULL
);
--**********************************************
--select * from cls2_paydeliveries;