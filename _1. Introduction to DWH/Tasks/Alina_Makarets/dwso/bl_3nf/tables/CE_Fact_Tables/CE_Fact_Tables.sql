CREATE TABLE CE_Fact_Tables (
        "Sales_srcid" VARCHAR2(10) NOT NULL,
        "Date_srcid" DATE,
        "Product_srcid" NUMBER(10),
        "Employee_srcid" NUMBER(10),
        "Store_srcid" NUMBER(4),
        "Customer_srcid" NUMBER(10),
        "Payment_srcid" NUMBER(4),
        "Unit_amount" NUMBER(4),
        "Total_sum" NUMBER(10),
        CONSTRAINT "FK_Date_srcid_Fact"
          FOREIGN KEY ("Date_srcid")
            REFERENCES CE_DATE("Date_srcid"),
        CONSTRAINT "FK_Product_srcid_Fact"
          FOREIGN KEY ("Product_srcid")
            REFERENCES CE_PRODUCTS("Product_srcid"),
        CONSTRAINT "FK_Employee_srcid_Fact"
          FOREIGN KEY ("Employee_srcid")
            REFERENCES CE_EMPLOYEES("Employee_srcid"),
        CONSTRAINT "FK_Store_srcid_Fact"
          FOREIGN KEY ("Store_srcid")
            REFERENCES CE_STORES("Store_srcid"),
        CONSTRAINT "FK_Customer_srcid_Fact"
          FOREIGN KEY ("Customer_srcid")
            REFERENCES CE_CUSTOMERS("Customer_srcid"),
        CONSTRAINT "FK_Payment_srcid_Fact"
          FOREIGN KEY ("Payment_srcid")
            REFERENCES CE_PAYMENTS("Payment_srcid"),
        CONSTRAINT "PK_Fact_tables"
          PRIMARY KEY ("Sales_srcid","Product_srcid","Unit_amount")
         );
