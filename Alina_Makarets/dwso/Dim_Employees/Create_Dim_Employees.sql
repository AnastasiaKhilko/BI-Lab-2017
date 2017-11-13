DROP TABLE EMPLOYEES;

CREATE TABLE EMPLOYEES (
        "Employee_id" NUMBER(10) NOT NULL,
        "First_name" VARCHAR2(40),
        "Last_name" VARCHAR2(40),
        "Phone" VARCHAR2(40),
        "Email"VARCHAR2(40),
        "Age" NUMBER(4),
        "Position_Name" VARCHAR2(40),
        "Manager_id" NUMBER(10)
         );
        
ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT "PK_Employee_id"
    PRIMARY KEY ("Employee_id");
    
ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT "FK_Manager_id"
    FOREIGN KEY ("Manager_id")
        REFERENCES EMPLOYEES("Employee_id");