DROP TABLE CUSTOMERS;

CREATE TABLE CUSTOMERS (
        "Customer_id" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40),
        "Last_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Email"VARCHAR2(40),
        "Age" NUMBER(4),
        "Discount" NUMBER(2),
        "Address_id" NUMBER(10)
         );
        
ALTER TABLE CUSTOMERS 
    ADD CONSTRAINT "PK_Customer_id"
    PRIMARY KEY ("Customer_id");
    
ALTER TABLE CUSTOMERS 
    ADD CONSTRAINT "FK_Address_id"
    FOREIGN KEY ("Address_id") 
        REFERENCES LOCATIONS("Address_id");