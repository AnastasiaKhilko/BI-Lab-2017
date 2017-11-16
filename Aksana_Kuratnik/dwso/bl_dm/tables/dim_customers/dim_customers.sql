create table dim_customers 
  (
    Customer_id         number(8) PRIMARY KEY,
    First_name       VARCHAR2(30) NOT NULL,
    Middle_name  VARCHAR2(4) ,
    Second_name    VARCHAR2(30) NOT NULL,
    age        NUMBER(3) NOT NULL,
    gender     VARCHAR2(10) NOT NULL,
    company    VARCHAR2(100) NOT NULL,
    profession VARCHAR2(50) NOT NULL,
    customer_address VARCHAR2(50) NOT NULL,
    customer_city VARCHAR2(50) NOT NULL,
    customer_state VARCHAR2(50) NOT NULL,
    customer_house_number NUMBER(8),
    customer_email_address        VARCHAR2(30) NOT NULL,
    customer_telephone_number      VARCHAR2(30) NOT NULL,
    customer_credit_card_name varchar2(60) not null
);
