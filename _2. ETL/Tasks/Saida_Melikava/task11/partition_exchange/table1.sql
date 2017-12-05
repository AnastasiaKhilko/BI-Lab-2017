EXECUTE pckg_drop.drop_proc(object_name=>'Fct_Sales1',object_type=>'table');
CREATE TABLE Fct_Sales1
  (
    Event_dt                DATE NOT NULL,
    Fct_customer_id         NUMBER(8) NOT NULL,
    Fct_employee_id         NUMBER(8) NOT NULL,
    Fct_store_id            NUMBER(8) NOT NULL,
    Fct_store_dist_id       NUMBER(8) NOT NULL,
    Fct_product_id          NUMBER(8) NOT NULL,
    Fct_payment_id          NUMBER(8) NOT NULL,
    Fct_check_id            NUMBER(8) NOT NULL,
    Fct_quantity            NUMBER(5) NOT NULL,
    Fct_discount            NUMBER(5,3) NOT NULL,
    Fct_unit_price_BYN      NUMBER(10,4) NOT NULL,
    Fct_unit_price_disc_BYN generated always AS (Fct_unit_price_BYN*Fct_discount),
    Fct_sales_Amount_BYN generated always    AS (Fct_unit_price_BYN*Fct_discount *Fct_quantity ) ,
    Fct_BYN_USD NUMBER(8,3) ,
    Fct_unit_price_USD generated always      AS (Fct_BYN_USD       * Fct_unit_price_BYN),
    Fct_unit_price_disc_USD generated always AS (CEIL(Fct_BYN_USD * Fct_unit_price_BYN*Fct_discount)) ,
    Fct_sales_Amount_USD generated always    AS (CEIL(Fct_BYN_USD * Fct_unit_price_BYN*Fct_discount *Fct_quantity)) ,
    Insert_DT               DATE DEFAULT(sysdate) NOT NULL,
    CONSTRAINT fk_date1 FOREIGN KEY (Event_dt) REFERENCES dim_time_day(full_date_dt),
    CONSTRAINT fk_customer1 FOREIGN KEY (Fct_customer_id) REFERENCES dim_customers(customer_sur_id),
    CONSTRAINT fk_employee1 FOREIGN KEY (Fct_employee_id) REFERENCES dim_employees(employee_sur_id),
    CONSTRAINT fk_store1 FOREIGN KEY (Fct_store_id) REFERENCES dim_stores_scd(store_sur_id),
    CONSTRAINT fk_product1 FOREIGN KEY (Fct_product_id) REFERENCES dim_products(product_sur_id),
    CONSTRAINT fk_payment1 FOREIGN KEY (Fct_payment_id) REFERENCES dim_payments(payment_sur_id)
  )
  PARTITION BY RANGE (event_dt)
  (
    PARTITION sales_2005_2010 VALUES LESS THAN (TO_DATE('01-JAN-2010','dd-Mon-yyyy'))tablespace tbs1, --2005-2020
    PARTITION sales_2010_2011 VALUES LESS THAN (TO_DATE('01-JAN-2011','dd-Mon-yyyy'))tablespace tbs2,
    PARTITION sales_2011_2012 VALUES LESS THAN (TO_DATE('01-JAN-2012','dd-Mon-yyyy')) tablespace tbs3 ,
    PARTITION sales_2012_2013 VALUES LESS THAN (TO_DATE('01-JAN-2013','dd-Mon-yyyy')) tablespace tbs4,
    PARTITION sales_2013_2014 VALUES LESS THAN (TO_DATE('01-JAN-2014','dd-Mon-yyyy')) tablespace tbs5,
    PARTITION sales_2014_2015 VALUES LESS THAN (TO_DATE('01-JAN-2015','dd-Mon-yyyy')) tablespace tbs6,
    PARTITION sales_2015_2016 VALUES LESS THAN (TO_DATE('01-JAN-2016','dd-Mon-yyyy')) tablespace tbs7,
    PARTITION sales_2016_2017 VALUES LESS THAN (TO_DATE('01-JAN-2017','dd-Mon-yyyy')) tablespace tbs8,
    PARTITION sales_2017_2018 VALUES LESS THAN (TO_DATE('01-JAN-2018','dd-Mon-yyyy'))tablespace tbs8,
    PARTITION sales_2018_2019 VALUES LESS THAN (TO_DATE('01-JAN-2019','dd-Mon-yyyy'))tablespace tbs8,
    PARTITION sales_2019_2020 VALUES LESS THAN (TO_DATE('01-JAN-2020','dd-Mon-yyyy'))tablespace tbs8,
    PARTITION sales_2020_2021 VALUES LESS THAN (TO_DATE('01-JAN-2021','dd-Mon-yyyy'))tablespace tbs8,
    PARTITION sales_2021_more VALUES LESS THAN (maxvalue)
  ) ;
