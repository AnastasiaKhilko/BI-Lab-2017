CREATE TABLE dim_customers (
    customer_id   NUMBER(10) NOT NULL,
    first_name    VARCHAR2(40 BYTE),
    last_name     VARCHAR2(40 BYTE),
    age           NUMBER(2),
    age_category  VARCHAR2(20 BYTE),
    email         VARCHAR2(40 BYTE),
    phone         VARCHAR2(40 BYTE),
    address       VARCHAR2(20 BYTE),
    city          VARCHAR2(20 BYTE),
    country       VARCHAR2(20 BYTE),
    region        VARCHAR2(20 BYTE),
    CONSTRAINT customer_id_pk PRIMARY KEY ( customer_id )
);