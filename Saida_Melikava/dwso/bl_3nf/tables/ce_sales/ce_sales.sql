CREATE TABLE ce_sales
  (
    Sales_id  NUMBER(8) PRIMARY KEY,
    Date_key            VARCHAR2(8) NOT NULL,
    Customer_id        VARCHAR2(8) NOT NULL,
    Employee_id        VARCHAR2(8) NOT NULL,
    Store_id           VARCHAR2(8) NOT NULL,
    Product_id         VARCHAR2(8) NOT NULL,
    Discount_id        VARCHAR2(8) NOT NULL,
    Currency_id        VARCHAR2(8) NOT NULL,
    Payment_id         VARCHAR2(8) NOT NULL,
    Check_id           VARCHAR2(8) NOT NULL,
    Quantity            NUMBER(5) NOT NULL,
    Unit_price_BYN      NUMBER(10,2) NOT NULL,
    Unit_price_disc_BYN NUMBER(10,2) NOT NULL,
    Sales_Amount_BYN    NUMBER(10,2) NOT NULL,
    Unit_price_cur      NUMBER(10,2) NOT NULL,
    Unit_price_disc_cur NUMBER(10,2) NOT NULL,
    Sales_Amount_cur    NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_date FOREIGN KEY (date_key) REFERENCES dimdate(date_key),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES ce_customer(customer_id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES ce_employee(employee_id),
    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES ce_store(store_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES ce_product(product_id),
    CONSTRAINT fk_discount FOREIGN KEY (discount_id) REFERENCES ce_discount(discount_id),
    CONSTRAINT fk_currency FOREIGN KEY (currency_id) REFERENCES ce_currency(currency_id),
    CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES ce_payment(payment_id)


  );

