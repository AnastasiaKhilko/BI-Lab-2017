CREATE TABLE DIM_STORES (
        "Store_id" NUMBER(4) NOT NULL,
        "Store_name" VARCHAR2(40) NOT NULL,
        "Phone" VARCHAR2(40) NOT NULL,
        "Address_id" NUMBER(10) NOT NULL,
        "Manager_id" NUMBER(10) NOT NULL,
        "Insert_dt" DATE NOT NULL,
        "Update_dt" DATE NOT NULL,
        CONSTRAINT "PK_Store_id"
          PRIMARY KEY ("Store_id"),
        CONSTRAINT "FK_Manager_id_Store"
          FOREIGN KEY ("Manager_id")
            REFERENCES DIM_EMPLOYEES("Employee_id"),
         CONSTRAINT "FK_Address_id_Store"
          FOREIGN KEY ("Address_id")
            REFERENCES DIM_LOCATIONS("Address_id")   
         );
