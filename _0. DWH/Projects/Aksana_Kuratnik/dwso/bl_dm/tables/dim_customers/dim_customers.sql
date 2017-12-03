DROP TABLE dim_customers;
CREATE TABLE dim_customers(
    customer_surr_id   NUMBER(38) NOT NULL,
    customer_id        NUMBER(38) NOT NULL,
    first_name         VARCHAR2(100 BYTE) NOT NULL,
    last_name          VARCHAR2(100 BYTE) NOT NULL,
    age                NUMBER(38) NOT NULL,
    email              VARCHAR2(100 BYTE) NOT NULL,
    phone              VARCHAR2(100 BYTE) NOT NULL,
    address            VARCHAR2(100 BYTE) NOT NULL,
    city               VARCHAR2(100 BYTE) NOT NULL,
    country            VARCHAR2(100 BYTE) NOT NULL,
    region             VARCHAR2(100 BYTE) NOT NULL,
    start_dt           DATE DEFAULT '01-JAN-1990',
    end_dt             DATE DEFAULT '31-DEC-9999',
    is_active          VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT customer_surr_id_pk PRIMARY KEY (customer_surr_id)
);