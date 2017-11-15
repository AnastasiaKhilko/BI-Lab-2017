DROP TABLE Fact_Tables;

CREATE TABLE Fact_Tables (
        "Sales_id" VARCHAR2(10) NOT NULL,
        "Date_id" DATE,
        "Product_id" NUMBER(10),
        "Employee_id" NUMBER(10),
        "Store_id" NUMBER(4),
        "Customer_id" NUMBER(10),
        "Payment_method" VARCHAR2(25),
        "Unit_amount" NUMBER(4),
        "Total_sum" NUMBER(10)
         );
         
ALTER TABLE Fact_Tables 
    ADD CONSTRAINT "FK_Date_id_Fact"
    FOREIGN KEY ("Date_id")
        REFERENCES DATE_DIM("Date_id");
         
ALTER TABLE Fact_Tables 
    ADD CONSTRAINT "FK_Product_id_Fact"
    FOREIGN KEY ("Product_id")
        REFERENCES PRODUCTS("Product_id");
        
ALTER TABLE Fact_Tables 
    ADD CONSTRAINT "FK_Employee_id_Fact"
    FOREIGN KEY ("Employee_id")
        REFERENCES EMPLOYEES("Employee_id");
        
ALTER TABLE Fact_Tables 
    ADD CONSTRAINT "FK_Store_id_Fact"
    FOREIGN KEY ("Store_id")
        REFERENCES STORES("Store_id");

ALTER TABLE Fact_Tables 
    ADD CONSTRAINT "FK_Customer_id_Fact"
    FOREIGN KEY ("Customer_id")
        REFERENCES CUSTOMERS("Customer_id");