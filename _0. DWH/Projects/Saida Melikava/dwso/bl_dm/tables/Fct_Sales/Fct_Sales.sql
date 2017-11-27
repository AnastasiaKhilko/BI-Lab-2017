EXECUTE pckg_drop.drop_proc(object_name=>'Fct_Sales',object_type=>'table');
CREATE TABLE Fct_Sales
  (
    Event_dt                DATE NOT NULL,
    Fct_customer_id         NUMBER(8) NOT NULL,
    Fct_employee_id         NUMBER(8) NOT NULL,
    Fct_store_id            NUMBER(8) NOT NULL,
    Fct_product_id          NUMBER(8) NOT NULL,
    Fct_payment_id          NUMBER(8) NOT NULL,
    Fct_check_id            NUMBER(8) NOT NULL,
    Fct_quantity            NUMBER(5) NOT NULL,
    Fct_discount            NUMBER(2,3) NOT NULL,
    Fct_unit_price_BYN      NUMBER(10,2) NOT NULL,
    Fct_unit_price_disc_BYN NUMBER(10,2) NOT NULL,
    Fct_sales_Amount_BYN    NUMBER(10,2) NOT NULL,
    Fct_BYN_USD             NUMBER(8,3) NOT NULL,
    Fct_unit_price_USD      NUMBER(10,2) NOT NULL,
    Fct_unit_price_disc_USD NUMBER(10,2) NOT NULL,
    Fct_sales_Amount_USD    NUMBER(10,2) NOT NULL,
    Insert_DT               DATE NOT NULL,
    Update_DT               DATE NOT NULL,
    CONSTRAINT fk_date FOREIGN KEY (Event_dt) REFERENCES dim_time_day(full_date_dt),
    CONSTRAINT fk_customer FOREIGN KEY (Fct_customer_id) REFERENCES dim_customers(customer_id),
    CONSTRAINT fk_employee FOREIGN KEY (Fct_employee_id) REFERENCES dim_employees_scd(employee_id),
    CONSTRAINT fk_store FOREIGN KEY (Fct_store_id) REFERENCES dim_stores_scd(store_id),
    CONSTRAINT fk_product FOREIGN KEY (Fct_product_id) REFERENCES dim_products(product_id),
    CONSTRAINT fk_payment FOREIGN KEY (Fct_payment_id) REFERENCES dim_payments(payment_id)
  );
COMMENT ON TABLE Fct_Sales
IS
  'Table Content: Fact table: all information ablut sales..   
Refresh Cycle/Window: Data is loaded often and for a long period of time.  
';
  COMMENT ON column Fct_Sales.event_dt
IS
  'Foreign key to Dim_Time_day';
  COMMENT ON column Fct_Sales.Fct_customer_id
IS
  'Foreign key to Dim_Customers';
  COMMENT ON column Fct_Sales.Fct_employee_id
IS
  'Foreign key to Dim_Employees';
  COMMENT ON column Fct_Sales.Fct_store_id
IS
  'Foreign key to Dim_Stores';
  COMMENT ON column Fct_Sales.Fct_product_id
IS
  'Foreign key to Dim_Products';
  COMMENT ON column Fct_Sales.Fct_payment_id
IS
  'Foreign key to Dim_Payments';
 
  COMMENT ON column Fct_Sales.Fct_unit_price_BYN
IS
  'Price for one piece in BYN';
  COMMENT ON column Fct_Sales.Fct_unit_price_disc_BYN
IS
  'Price for one piece with discount in BYN';
  COMMENT ON column Fct_Sales.Fct_sales_amount_BYN
IS
  'Total in BYN';
  COMMENT ON column Fct_Sales.Fct_BYN_USD
IS
  'Exchange rate';
  COMMENT ON column Fct_Sales.Fct_unit_price_USD
IS
  'Price for one piece in USD';
  COMMENT ON column Fct_Sales.Fct_unit_price_disc_USD
IS
  'Price for one piece with discount in USD';
  COMMENT ON column Fct_Sales.Fct_sales_amount_USD
IS
  'Total in USD';
  COMMENT ON column Fct_Sales.Insert_DT
IS
  'When data was loaded';
  COMMENT ON column Fct_Sales.Update_DT
IS
  'When data was updated';
  /*GRANT SELECT ON dim_template TO some_user;*/
