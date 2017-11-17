CREATE TABLE CE_CUSTOMERS (
        "Customer_srcid" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40),
        "Last_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Email"VARCHAR2(40),
        "Age" NUMBER(4),
        "Discount" NUMBER(2),
        "Country_srcid" NUMBER(10),
        CONSTRAINT "PK_Customer_srcid"
          PRIMARY KEY ("Customer_srcid"),
        CONSTRAINT "FK_Country_srcid_Cus"
          FOREIGN KEY ("Country_srcid") 
              REFERENCES CE_COUNTRIES("Country_srcid")
         );
  