CREATE TABLE CE_EMPLOYEES (
        "Employee_srcid" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40),
        "Last_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Email"VARCHAR2(40),
        "Age" NUMBER(4),
        "Position_Name" VARCHAR2(40),
        "Manager_srcid" NUMBER(10),
        "Start_dt" DATE NOT NULL,
        "End_dt" DATE NOT NULL,
        "Is_current" VARCHAR(4) NOT NULL,
        CONSTRAINT "PK_Employee_srcid"
          PRIMARY KEY ("Employee_srcid"),
        CONSTRAINT "FK_Manager_srcid"
          FOREIGN KEY ("Manager_srcid")
            REFERENCES CE_EMPLOYEES("Employee_srcid")
         );
        
