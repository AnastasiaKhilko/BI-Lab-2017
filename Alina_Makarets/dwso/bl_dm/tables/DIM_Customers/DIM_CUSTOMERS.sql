CREATE TABLE DIM_CUSTOMERS (
        "Customer_id" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40) NOT NULL,
        "Last_name" VARCHAR2(40) NOT NULL,
        "Phone" VARCHAR2(40) NOT NULL,
        "Email"VARCHAR2(40) NOT NULL,
        "Age" NUMBER(4) NOT NULL,
        "Discount" NUMBER(2) NOT NULL,
        "Address_id" NUMBER(10) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Update_dt" DATE NOT NULL,
        CONSTRAINT "PK_Customer_id"
          PRIMARY KEY ("Customer_id"),
        CONSTRAINT "FK_Address_id"
          FOREIGN KEY ("Address_id") 
            REFERENCES DIM_LOCATIONS("Address_id")
         );
  