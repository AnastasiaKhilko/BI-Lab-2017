CREATE TABLE FCT_SALES (
        "Sales_id" VARCHAR2(10) NOT NULL,
        "Event_dt" DATE NOT NULL,
        "Product_id" NUMBER(10) NOT NULL,
        "Employee_id" NUMBER(10) NOT NULL,
        "Store_id" NUMBER(4) NOT NULL,
        "Customer_id" NUMBER(10) NOT NULL,
        "Payment_method" VARCHAR2(25) NOT NULL,
        "Unit_amount" NUMBER(4) NOT NULL,
        "Total_sum" NUMBER(10) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Update_dt" DATE NOT NULL,
        CONSTRAINT "FK_Event_dt_Fact"
          FOREIGN KEY ("Event_dt")
            REFERENCES DIM_TIME_DAY("Date_id"),
       CONSTRAINT "FK_Product_id_Fact"
          FOREIGN KEY ("Product_id")
            REFERENCES DIM_PRODUCTS("Product_id"),
       CONSTRAINT "FK_Employee_id_Fact"
          FOREIGN KEY ("Employee_id")
            REFERENCES DIM_EMPLOYEES("Employee_id"),
        CONSTRAINT "FK_Store_id_Fact"
          FOREIGN KEY ("Store_id")
            REFERENCES DIM_STORES("Store_id"),
        CONSTRAINT "FK_Customer_id_Fact"
          FOREIGN KEY ("Customer_id")
            REFERENCES DIM_CUSTOMERS("Customer_id")
         );
