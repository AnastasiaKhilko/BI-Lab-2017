CREATE TABLE customers
  (
    Customer_id         number(8) PRIMARY KEY,
    First_name       VARCHAR2(30) NOT NULL,
    Middle_name  VARCHAR2(4) ,
    Second_name    VARCHAR2(30) NOT NULL,
    age        NUMBER(3) NOT NULL,
    gender     VARCHAR2(10) NOT NULL,
    company    VARCHAR2(100) NOT NULL,
    profession VARCHAR2(50) NOT NULL,
    customer_address_id NUMBER(8) NOT NULL,
    customer_contact_id   number(8) not null,
    credit_card_id number(8) not null,
    CONSTRAINT fk_cust_address FOREIGN KEY (customer_address_id) REFERENCES address(address_id),
    CONSTRAINT fk_cust_cont FOREIGN KEY (customer_contact_id) REFERENCES contacts(contact_id),
    CONSTRAINT fk_cust_credc FOREIGN KEY (credit_card_id) REFERENCES credit_cards(credit_card_id)
    
  );

