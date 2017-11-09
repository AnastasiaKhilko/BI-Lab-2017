CREATE TABLE customer_location_dimension (
    address_id    NUMBER(10) NOT NULL,
    postal_code   NUMBER(10),
    address       VARCHAR2(20 BYTE),
    city          VARCHAR2(20 BYTE),
    country       VARCHAR2(20 BYTE),
    region        VARCHAR2(20 BYTE),
    CONSTRAINT address_id_pk PRIMARY KEY ( address_id ) ENABLE
);

CREATE TABLE customer_dimension (
    customer_id   NUMBER(10) NOT NULL,
    first_name    VARCHAR2(40 BYTE),
    last_name     VARCHAR2(40 BYTE),
    age           NUMBER(2),
    email         VARCHAR2(40 BYTE),
    phone         VARCHAR2(40 BYTE),
    address_id    NUMBER(10) NOT NULL,
    CONSTRAINT customer_id_pk PRIMARY KEY ( customer_id ) ENABLE,
    CONSTRAINT address_id_fk FOREIGN KEY ( address_id )
        REFERENCES customer_location_dimension ( address_id )
);

CREATE TABLE collection_dimension (
    collection_id            NUMBER(10) NOT NULL,
    collection_name          VARCHAR2(10 BYTE),
    collection_season        VARCHAR2(10 BYTE),
    collection_description   VARCHAR2(40 BYTE),
    collection_date          DATE,
    CONSTRAINT collection_id_pk PRIMARY KEY ( collection_id ) ENABLE
);

CREATE TABLE line_dimension (
    line_id            NUMBER(10) NOT NULL,
    line_name          VARCHAR2(10 BYTE),
    line_description   VARCHAR2(40 BYTE),
    CONSTRAINT line_id_pk PRIMARY KEY ( line_id ) ENABLE
);

CREATE TABLE product_type_dimension (
    product_type_id   NUMBER(10) NOT NULL,
    product_type      VARCHAR2(10 BYTE),
    CONSTRAINT product_type_id_pk PRIMARY KEY ( product_type_id ) ENABLE
);

CREATE TABLE size_grid_dimension (
    size_id                 NUMBER(10) NOT NULL,
    size_code               VARCHAR2(10 BYTE),
    country_standart_code   VARCHAR2(10 BYTE),
    sex                     VARCHAR2(10 BYTE),
    CONSTRAINT size_id_pk PRIMARY KEY ( size_id ) ENABLE
);

CREATE TABLE product_dimension (
    product_id            NUMBER(10) NOT NULL,
    product_code          NUMBER(10) NOT NULL,
    collection_id         NUMBER(10),
    line_id               NUMBER(10),
    product_type_id       NUMBER(10),
    product_name          VARCHAR2(10 BYTE) NOT NULL,
    product_description   VARCHAR2(40 BYTE),
    size_id               NUMBER(10),
    color                 VARCHAR2(40 BYTE),
    price                 NUMBER(10),
    product_balance       NUMBER(10),
    CONSTRAINT product_id_pk PRIMARY KEY ( product_id ) ENABLE,
    CONSTRAINT collection_id_fk FOREIGN KEY ( collection_id )
        REFERENCES collection_dimension ( collection_id ),
    CONSTRAINT line_id_fk FOREIGN KEY ( line_id )
        REFERENCES line_dimension ( line_id ),
    CONSTRAINT product_type_id_fk FOREIGN KEY ( product_type_id )
        REFERENCES product_type_dimension ( product_type_id ),
    CONSTRAINT size_id_fk FOREIGN KEY ( size_id )
        REFERENCES size_grid_dimension ( size_id )
);

CREATE TABLE store_location_dimension (
    address_id    NUMBER(10) NOT NULL,
    postal_code   NUMBER(10) NOT NULL,
    address       VARCHAR2(20 BYTE) NOT NULL,
    city          VARCHAR2(20 BYTE) NOT NULL,
    country       VARCHAR2(20 BYTE) NOT NULL,
    region        VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT address_store_id_pk PRIMARY KEY ( address_id ) ENABLE
);

CREATE TABLE manager_dimension (
    manager_id      NUMBER(10) NOT NULL,
    first_name      VARCHAR2(40 BYTE) NOT NULL,
    last_name       VARCHAR2(40 BYTE) NOT NULL,
    position_name   VARCHAR2(40 BYTE) NOT NULL,
    email           VARCHAR2(40 BYTE) NOT NULL,
    phone           VARCHAR2(40 BYTE) NOT NULL,
    CONSTRAINT manager_id_pk PRIMARY KEY ( manager_id ) ENABLE
);

CREATE TABLE store_dimension (
    store_id     NUMBER(10) NOT NULL,
    manager_id   NUMBER(10),
    phone        VARCHAR2(40 BYTE) NOT NULL,
    address_id   NUMBER(10) NOT NULL,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id ) ENABLE,
    CONSTRAINT manager_id_fk FOREIGN KEY ( manager_id )
        REFERENCES manager_dimension ( manager_id ),
    CONSTRAINT address_sd_id_fk FOREIGN KEY ( address_id )
        REFERENCES store_location_dimension ( address_id )
);

CREATE TABLE sales_employee_dimension (
    sales_employee_id   NUMBER(10) NOT NULL,
    first_name          VARCHAR2(40 BYTE) NOT NULL,
    last_name           VARCHAR2(40 BYTE) NOT NULL,
    position_grade      VARCHAR2(40 BYTE) NOT NULL,
    position_name       VARCHAR2(40 BYTE) NOT NULL,
    email               VARCHAR2(40 BYTE) NOT NULL,
    phone               VARCHAR2(40 BYTE) NOT NULL,
    start_date          DATE NOT NULL,
    CONSTRAINT sales_employee_id_pk PRIMARY KEY ( sales_employee_id ) ENABLE
);

CREATE TABLE date_dimension (
    date_id             NUMBER(10) NOT NULL,
    fulldate            VARCHAR2(10) NOT NULL,
    dayofmonth          VARCHAR2(2) NOT NULL,
    dayname             VARCHAR2(9) NOT NULL,
    dayofweek           VARCHAR2(1) NOT NULL,
    dayofweekinmonth    VARCHAR2(2) NOT NULL,
    dayofweekinyear     VARCHAR2(2) NOT NULL,
    dayofquarter        VARCHAR2(3) NOT NULL,
    dayofyear           VARCHAR2(3) NOT NULL,
    weekofmonth         VARCHAR2(1) NOT NULL,
    weekofquarter       VARCHAR2(2) NOT NULL,
    weekofyear          VARCHAR2(2) NOT NULL,
    monthnumber         VARCHAR2(2) NOT NULL,
    monthname           VARCHAR2(9) NOT NULL,
    monthofquarter      VARCHAR2(2) NOT NULL,
    quarter             VARCHAR2(1) NOT NULL,
    quartername         VARCHAR2(9) NOT NULL,
    yearnumber          VARCHAR2(4) NOT NULL,
    monthyear           VARCHAR2(10) NOT NULL,
    firstdayofmonth     DATE NOT NULL,
    lastdayofmonth      DATE NOT NULL,
    firstdayofquarter   DATE NOT NULL,
    lastdayofquarter    DATE NOT NULL,
    firstdayofyear      DATE NOT NULL,
    lastdayofyear       DATE NOT NULL,
    CONSTRAINT date_id_pk PRIMARY KEY ( date_id ) ENABLE
);

CREATE TABLE payment_method_dimension (
    payment_method_id     NUMBER(10) NOT NULL,
    payment_method_name   VARCHAR2(40 BYTE) NOT NULL,
    bank_name             VARCHAR2(40 BYTE),
    CONSTRAINT payment_method_id_pk PRIMARY KEY ( payment_method_id ) ENABLE
);

CREATE TABLE promotion_dimension (
    promotion_id               NUMBER(10) NOT NULL,
    promotion_type             VARCHAR2(40 BYTE) NOT NULL,
    promotion_description      VARCHAR2(40 BYTE) NOT NULL,
    promotion_price            NUMBER(10),
    price_decreasing_percent   NUMBER(10),
    free_unit_amount           NUMBER(10),
    start_date                 DATE NOT NULL,
    end_date                   DATE,
    CONSTRAINT promotion_id_pk PRIMARY KEY ( promotion_id ) ENABLE
);

CREATE TABLE retail_sales_fact (
    sales_id            NUMBER(10) NOT NULL,
    receipt_number      NUMBER(10) NOT NULL,
    date_id             NUMBER(10) NOT NULL,
    product_id          NUMBER(10) NOT NULL,
    sales_employee_id   NUMBER(10) NOT NULL,
    customer_id         NUMBER(10),
    store_id            NUMBER(10) NOT NULL,
    payment_method_id   NUMBER(10) NOT NULL,
    promotion_id        NUMBER(10),
    receipt_sum         NUMBER(10) NOT NULL,
    unit_amount         NUMBER(10) NOT NULL,
    CONSTRAINT date_id_fk FOREIGN KEY ( date_id )
        REFERENCES date_dimension ( date_id ),
    CONSTRAINT product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product_dimension ( product_id ),
    CONSTRAINT customer_id_fk FOREIGN KEY ( customer_id )
        REFERENCES customer_dimension ( customer_id ),
    CONSTRAINT store_id_fk FOREIGN KEY ( store_id )
        REFERENCES store_dimension ( store_id ),
    CONSTRAINT sales_employee_id_fk FOREIGN KEY ( sales_employee_id )
        REFERENCES sales_employee_dimension ( sales_employee_id ),
    CONSTRAINT payment_method_id_fk FOREIGN KEY ( payment_method_id )
        REFERENCES payment_method_dimension ( payment_method_id ),
    CONSTRAINT promotion_id_fk FOREIGN KEY ( promotion_id )
        REFERENCES promotion_dimension ( promotion_id )
);