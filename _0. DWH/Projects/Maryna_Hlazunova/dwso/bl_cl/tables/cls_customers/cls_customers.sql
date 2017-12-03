/**===============================================*\
Name...............:   Cleansing table cls_customers BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
DROP TABLE cls_customers;
--**********************************************

CREATE TABLE cls_customers (
    customer_code       NUMBER(8),
    last_name           VARCHAR2(50),
    first_name          VARCHAR2(50),
    middle_name         VARCHAR2(50),
    birthdate           DATE,
    gender              VARCHAR2(3),
    personal_discount   NUMBER(2),
    cust_loc_id         NUMBER(6),
    locality_address    VARCHAR2(150),
    start_dt            DATE,
    end_dt              DATE,
    is_active           VARCHAR2(1 CHAR)
);

--**********************************************
-- select * from cls_customers;