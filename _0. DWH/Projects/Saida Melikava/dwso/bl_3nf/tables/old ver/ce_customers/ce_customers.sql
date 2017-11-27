CREATE TABLE ce_customers
  (
    Customer_code       VARCHAR2(8) PRIMARY KEY,
    Customer_name       VARCHAR2(30) NOT NULL,
    Customer_surname    VARCHAR2(30) NOT NULL,
    Customer_email      VARCHAR2(50) NOT NULL,
    Customer_phone      VARCHAR2(30) NOT NULL,
    Customer_age        NUMBER(3) NOT NULL,
    Customer_card       VARCHAR2(30) NOT NULL,
    Customer_address_id NUMBER(8) NOT NULL,
    insert_dt           DATE NOT NULL,
    update_dt           DATE NOT NULL,
    CONSTRAINT fk_cust_card FOREIGN KEY (Customer_card) REFERENCES ce_customer_cards(Customer_card),
    CONSTRAINT fk_cust_address FOREIGN KEY (customer_address_id) REFERENCES ce_addresses(address_id)
  );
