 EXECUTE pckg_drop.drop_proc(object_name=>'Fct_Sales_2018',object_type=>'table');
CREATE TABLE Fct_Sales_2018
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
  PARTITION BY RANGE
  (
    event_dt
  )
 SUBPARTITION BY LIST (Fct_store_dist_id)
   SUBPARTITION TEMPLATE 
      (SUBPARTITION south VALUES ('1') TABLESPACE tbs1,
       SUBPARTITION fareast VALUES ('2') TABLESPACE tbs2,
       SUBPARTITION volga VALUES ('3') TABLESPACE tbs3,
       SUBPARTITION siberia VALUES ('4') TABLESPACE tbs4,
       SUBPARTITION centr VALUES ('5') TABLESPACE tbs5,
       SUBPARTITION northcauc VALUES ('6') TABLESPACE tbs6,
       SUBPARTITION northwest VALUES ('7') TABLESPACE tbs7,
       SUBPARTITION ural VALUES ('8') TABLESPACE tbs8
      )
  (
    
    PARTITION sales_2018_newtab VALUES LESS THAN (maxvalue)
  ) ;
