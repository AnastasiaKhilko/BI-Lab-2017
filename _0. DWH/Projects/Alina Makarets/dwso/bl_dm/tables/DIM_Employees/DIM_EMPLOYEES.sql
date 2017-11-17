CREATE TABLE DIM_EMPLOYEES (
        "Employee_id" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40) NOT NULL,
        "Last_name" VARCHAR2(40) NOT NULL,
        "Phone" VARCHAR2(40) NOT NULL,
        "Email"VARCHAR2(40) NOT NULL,
        "Age" NUMBER(4) NOT NULL,
        "Position_Name" VARCHAR2(40) NOT NULL,
        "Manager_id" NUMBER(10) NOT NULL,
        "Start_dt" DATE NOT NULL,
        "End_dt" DATE NOT NULL,
        "Is_active" VARCHAR2(4) NOT NULL,
        CONSTRAINT "PK_Employee_id"
          PRIMARY KEY ("Employee_id"),
        CONSTRAINT "FK_Manager_id"
          FOREIGN KEY ("Manager_id")
            REFERENCES DIM_EMPLOYEES("Employee_id")  
         );
