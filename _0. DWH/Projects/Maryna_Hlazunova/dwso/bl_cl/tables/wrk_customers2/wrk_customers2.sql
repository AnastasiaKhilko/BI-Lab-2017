/**===============================================*\
Name...............:   Cleansing table wrk_customers2 BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
DROP TABLE wrk_customers2;
--**********************************************

CREATE TABLE wrk_customers2 (
    customer_code       NUMBER(8),
    last_name           VARCHAR2(50),
    first_name          VARCHAR2(50),
    middle_name         VARCHAR2(50),
    birthdate           DATE,
    gender              VARCHAR2(3),
    personal_discount   NUMBER(2),
    locality_desc       VARCHAR2(100 CHAR),
    locality_address    VARCHAR2(150)
);

--**********************************************
-- select * from wrk_customers2;