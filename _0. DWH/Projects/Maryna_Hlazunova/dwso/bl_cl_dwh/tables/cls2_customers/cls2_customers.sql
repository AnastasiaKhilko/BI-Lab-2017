/**===============================================*\
Name...............:   Cleansing table cls2_customers BL_CL_DWH layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   01-Dec-2017
\*=============================================== */
DROP TABLE cls2_customers;
--**********************************************

CREATE TABLE cls2_customers (
    customer_srcid               NUMBER(12,0) NOT NULL,
    customer_last_name           VARCHAR2(50 CHAR) NOT NULL,
    customer_first_name          VARCHAR2(50 CHAR) NOT NULL,
    customer_middle_name         VARCHAR2(50 CHAR) NOT NULL,
    customer_birthdate           DATE,
    customer_gender              VARCHAR2(3 CHAR) NOT NULL,
    customer_personal_discount   NUMBER(2,0),
    customer_loc_srcid           NUMBER(6,0) NOT NULL,
    customer_location_name       VARCHAR2(100 CHAR) NOT NULL,
    customer_address             VARCHAR2(100 CHAR) NOT NULL,
    customer_loc_type_srcid      NUMBER(2) NOT NULL,
    customer_loc_type_short      VARCHAR2(10 CHAR) NOT NULL,
    customer_loc_type_full       VARCHAR2(25 CHAR) NOT NULL,
    customer_dis_srcid           NUMBER(3,0) NOT NULL,
    customer_district            VARCHAR2(100 CHAR) NOT NULL,
    customer_reg_srcid           NUMBER(2,0) NOT NULL,
    customer_region              VARCHAR2(100 CHAR) NOT NULL,
    start_dt                     DATE NOT NULL,
    end_dt                       DATE NOT NULL,
    is_active                    VARCHAR2(1 CHAR) NOT NULL
);
--**********************************************
--select * from cls2_customers;