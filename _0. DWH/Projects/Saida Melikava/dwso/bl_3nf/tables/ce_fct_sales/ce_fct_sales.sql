EXECUTE pckg_drop.drop_proc(object_name=>'ce_fct_sales', object_type=>'table');
CREATE TABLE ce_fct_sales
  (
    Sales_id           NUMBER(8) PRIMARY KEY,
    Event_DT           DATE NOT NULL,
    Fct_customer_id    NUMBER(8) ,
    Fct_employee_id    NUMBER(8) ,
    Fct_store_id       NUMBER(8) ,
    Fct_product_id     NUMBER(8) ,
    Fct_payment_id     NUMBER(8) ,
    Fct_check_id       NUMBER(8) ,
    Fct_quantity       NUMBER(5) ,
    Fct_discount       NUMBER(5,3) ,
    Fct_unit_price_BYN NUMBER(10,2) ,
    Fct_unit_price_disc_BYN generated always AS (Fct_unit_price_BYN*Fct_discount),
    Fct_sales_Amount_BYN generated always    AS (Fct_unit_price_BYN*Fct_discount *Fct_quantity ) ,
    Fct_BYN_USD NUMBER(8,3) ,
    Fct_unit_price_USD generated always      AS (Fct_BYN_USD       * Fct_unit_price_BYN),
    Fct_unit_price_disc_USD generated always AS (ROUND(Fct_BYN_USD * Fct_unit_price_BYN*Fct_discount)) ,
    Fct_sales_Amount_USD generated always    AS (ROUND(Fct_BYN_USD * Fct_unit_price_BYN*Fct_discount *Fct_quantity )),
    Insert_DT DATE DEFAULT(sysdate) NOT NULL
  );
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_date FOREIGN KEY (Event_DT) REFERENCES dim_time_day(full_date_dt);
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_customer FOREIGN KEY (fct_customer_id) REFERENCES ce_customers(customer_id);
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_employee FOREIGN KEY (fct_employee_id) REFERENCES ce_employees(employee_id);
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_store FOREIGN KEY (fct_store_id) REFERENCES ce_stores(store_id);
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_product FOREIGN KEY (fct_product_id) REFERENCES ce_catalog(prod_id);
ALTER TABLE ce_fct_sales ADD CONSTRAINT fk_payment FOREIGN KEY (fct_payment_id) REFERENCES ce_payments(payment_id);
