CREATE TABLE dim_customers_scd (
    customer_surr_id   NUMBER(38) NOT NULL,
    customer_id        VARCHAR2(100 BYTE) NOT NULL,
    first_name         VARCHAR2(100 BYTE) NOT NULL,
    last_name          VARCHAR2(100 BYTE) NOT NULL,
    age                NUMBER(10) NOT NULL,
    email              VARCHAR2(100 BYTE) NOT NULL,
    phone              VARCHAR2(100 BYTE) NOT NULL,
    address            VARCHAR2(100 BYTE) NOT NULL,
    city               VARCHAR2(100 BYTE) NOT NULL,
    country            VARCHAR2(100 BYTE) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             VARCHAR2(50 BYTE) NOT NULL,
    is_active          VARCHAR2(10 BYTE) NOT NULL,
    CONSTRAINT customer_surr_id_pk PRIMARY KEY ( customer_surr_id )
);

CREATE TABLE dim_products_scd (
    product_surr_id     NUMBER(10) NOT NULL,
    product_id          VARCHAR2(50 BYTE) NOT NULL,
    product_desc        VARCHAR2(50 BYTE) NOT NULL,
    color               VARCHAR2(40 BYTE) NOT NULL,
    price               VARCHAR2(40 BYTE) NOT NULL,
    start_dt            DATE NOT NULL,
    end_dt              VARCHAR2(50 BYTE) NOT NULL,
    is_active           VARCHAR2(10) NOT NULL,
    CONSTRAINT product_surr_id_pk PRIMARY KEY ( product_surr_id )
);

CREATE TABLE dim_employees_scd (
    employee_surr_id   NUMBER(10) NOT NULL,
    employee_id        VARCHAR2(40 BYTE) NOT NULL,
    employee_desc      VARCHAR2(100 BYTE) NOT NULL,
    first_name         VARCHAR2(40 BYTE) NOT NULL,
    last_name          VARCHAR2(40 BYTE) NOT NULL,
    position_name      VARCHAR2(100 BYTE) NOT NULL,
    email              VARCHAR2(100 BYTE) NOT NULL,
    phone              VARCHAR2(100 BYTE) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             VARCHAR2(40 BYTE) NOT NULL,
    is_active          VARCHAR2(10) NOT NULL,
    CONSTRAINT employee_surr_id_pk PRIMARY KEY ( employee_surr_id )
);

CREATE TABLE dim_time_day (
    date_dt                  DATE NOT NULL,
    week_day_full_name       VARCHAR2(10) NOT NULL,
    week_day_short_name      VARCHAR2(10) NOT NULL,
    day_number_of_week       NUMBER(10) NOT NULL,
    day_number_of_month      NUMBER(10) NOT NULL,
    day_number_of_year       NUMBER(10) NOT NULL,
    month_year               VARCHAR2(10) NOT NULL,
    month_full_name          VARCHAR2(10) NOT NULL,
    month_short_name         VARCHAR2(10) NOT NULL,
    month_number_of_year     NUMBER(10) NOT NULL,
    quarter_year             VARCHAR2(10) NOT NULL,
    quarter_number_of_year   VARCHAR2(10) NOT NULL,
    half_year_number         VARCHAR2(10) NOT NULL,
    half_year                VARCHAR2(10) NOT NULL,
    year                     VARCHAR2(10) NOT NULL,
    CONSTRAINT date_dt_pk PRIMARY KEY ( date_dt )
);


CREATE TABLE dim_stores
  (
    store_surr_id NUMBER(10) NOT NULL,
    store_id      VARCHAR2(40 BYTE) NOT NULL,
    store_desc    VARCHAR2(100 BYTE) NOT NULL,
    phone         VARCHAR2(40 BYTE) NOT NULL,
    address       VARCHAR2(100 BYTE) NOT NULL,
    city          VARCHAR2(50 BYTE) NOT NULL,
    country       VARCHAR2(50 BYTE) NOT NULL,
    insert_dt     DATE NOT NULL,
    update_dt     VARCHAR2(50 BYTE) NOT NULL,
    CONSTRAINT store_surr_id_pk PRIMARY KEY ( store_surr_id )
  );

CREATE TABLE fct_retail_sales_dd (
    receipt_id               NUMBER(38) NOT NULL,
    event_dt                 DATE NOT NULL,
    product_surr_id          NUMBER(38) NOT NULL,
    employee_surr_id         NUMBER(38) NOT NULL,
    customer_surr_id         NUMBER(38) NOT NULL,
    store_surr_id            NUMBER(38) NOT NULL,
    tot_sale_sum             NUMBER(38) NOT NULL,
    tot_sale_amount          NUMBER(38) NOT NULL,
    insert_dt                DATE NOT NULL,
    update_dt                DATE NOT NULL,
    CONSTRAINT sl_date_id_fk FOREIGN KEY ( event_dt )
        REFERENCES dim_time_day ( date_dt ),
    CONSTRAINT sl_product_surr_id_fk FOREIGN KEY ( product_surr_id )
        REFERENCES dim_products_scd ( product_surr_id ),
    CONSTRAINT sl_customer_surr_id_fk FOREIGN KEY ( customer_surr_id )
        REFERENCES dim_customers_scd ( customer_surr_id ),
    CONSTRAINT sl_store_surr_id_fk FOREIGN KEY ( store_surr_id )
        REFERENCES dim_stores ( store_surr_id ),
    CONSTRAINT sl_employee_surr_id_fk FOREIGN KEY ( employee_surr_id )
        REFERENCES dim_employees_scd ( employee_surr_id )
);