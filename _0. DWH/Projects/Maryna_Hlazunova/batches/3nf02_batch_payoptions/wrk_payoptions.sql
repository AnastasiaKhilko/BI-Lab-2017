/**===============================================*\
Name...............:   Cleansing table wrk_payoptions BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
DROP TABLE wrk_payoptions;
--**********************************************

CREATE TABLE wrk_payoptions (
    nat_code    VARCHAR2(3 CHAR),
    payoption   VARCHAR2(100 CHAR)
);
--**********************************************
--select * from wrk_payoptions;