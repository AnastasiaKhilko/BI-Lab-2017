/**===============================================*\
Name...............:   Cleansing table wrk_payoptions BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
DROP TABLE wrk_customers;
--**********************************************

CREATE TABLE wrk_customers (
    nat_code        NUMBER(8),
    customer_name   VARCHAR2(200 CHAR),
    birthdate       VARCHAR2(10 CHAR),
    locality        VARCHAR2(100 CHAR),
    street          VARCHAR2(100 CHAR),
    house           NUMBER(2),
    appartment      NUMBER(3),
    discount        NUMBER(2)
);
--**********************************************
-- select * from wrk_customers;