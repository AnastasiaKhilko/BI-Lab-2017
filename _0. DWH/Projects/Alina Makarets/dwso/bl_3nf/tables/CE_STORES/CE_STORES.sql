CREATE TABLE CE_STORES (
        "Store_srcid" NUMBER(4) NOT NULL,
        "Store_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Country_srcid" NUMBER(10),
        "Manager_srcid" NUMBER(10),
        CONSTRAINT "PK_Store_srcid"
          PRIMARY KEY ("Store_srcid"),
        CONSTRAINT "FK_Manager_srcid_Store"
          FOREIGN KEY ("Manager_srcid")
            REFERENCES CE_EMPLOYEES("Employee_srcid"),
        CONSTRAINT "FK_Country_srcid_Store"
          FOREIGN KEY ("Country_srcid")
            REFERENCES CE_COUNTRIES("Country_srcid")    
         );
        
