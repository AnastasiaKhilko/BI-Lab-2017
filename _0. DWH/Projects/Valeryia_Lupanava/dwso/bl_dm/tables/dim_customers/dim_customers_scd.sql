CREATE TABLE dim_customers_scd (
    customer_surr_id   NUMBER(10) NOT NULL,
    customer_id        NUMBER(10) NOT NULL,
    customer_desc      VARCHAR2(40 BYTE) NOT NULL,
    first_name         VARCHAR2(40 BYTE) NOT NULL,
    last_name          VARCHAR2(40 BYTE) NOT NULL,
    age                NUMBER(2) NOT NULL,
    age_category       VARCHAR2(20 BYTE) NOT NULL,
    email              VARCHAR2(40 BYTE) NOT NULL,
    phone              VARCHAR2(40 BYTE) NOT NULL,
    address            VARCHAR2(20 BYTE) NOT NULL,
    city               VARCHAR2(20 BYTE) NOT NULL,
    country            VARCHAR2(20 BYTE) NOT NULL,
    region             VARCHAR2(20 BYTE) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             DATE NOT NULL,
    is_active          VARCHAR2(4) NOT NULL,
    CONSTRAINT customer_surr_id_pk PRIMARY KEY ( customer_surr_id )
);