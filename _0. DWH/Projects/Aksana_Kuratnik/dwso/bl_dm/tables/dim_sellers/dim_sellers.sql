create TABLE dim_sellers
  (
    seller_id         number(8) PRIMARY KEY,
    First_name       VARCHAR2(30) NOT NULL,
    Middle_name  VARCHAR2(4) ,
    Second_name    VARCHAR2(30) NOT NULL,
    age        NUMBER(3) NOT NULL,
    gender     VARCHAR2(10) NOT NULL,
    seller_address VARCHAR2(50) NOT NULL,
    seller_city VARCHAR2(50) NOT NULL,
    seller_state VARCHAR2(50) NOT NULL,
    seller_house_number NUMBER(8),
    seller_email_address        VARCHAR2(30) NOT NULL,
    seller_telephone_number      VARCHAR2(30) NOT NULL,
    seller_credit_card_name varchar2(60) not null   
  );
