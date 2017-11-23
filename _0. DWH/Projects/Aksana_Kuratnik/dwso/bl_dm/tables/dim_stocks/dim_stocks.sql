 create TABLE dim_stocks
        (   Stock_id              NUMBER(8) PRIMARY KEY,
    Stock_name            VARCHAR2(30) NOT NULL,
    stock_email_address        VARCHAR2(30) NOT NULL,
    stock_telephone_number      VARCHAR2(30) NOT NULL,
    stock_address VARCHAR2(50) NOT NULL,
    stock_city VARCHAR2(50) NOT NULL,
    stock_state VARCHAR2(50) NOT NULL,
    stock_house_number NUMBER(8));