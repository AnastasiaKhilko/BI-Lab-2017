CREATE TABLE DimEmployee_SCD
  (
    Employee_key             NUMBER(8) PRIMARY KEY,
    Employee_id              VARCHAR2(8) NOT NULL,
    Employee_name            VARCHAR2(30) NOT NULL,
    Employee_surname         VARCHAR2(30) NOT NULL,
    Employee_email           VARCHAR2(50) NOT NULL,
    Employee_phone           VARCHAR2(30) NOT NULL,
    Employee_department_name VARCHAR2(30) NOT NULL,
    Employee_manager_key     NUMBER(8),
    Employee_manager_name    VARCHAR2(70),
    Employee_store_key       NUMBER(8),
    Employee_store_name      VARCHAR2(30) NOT NULL,
    Employee_store_city      VARCHAR2(50) NOT NULL,
    Employee_store_address   VARCHAR2(50) NOT NULL,
    Start_DT                 DATE NOT NULL,
    End_DT                   DATE NOT NULL,
    Current_flag             VARCHAR2(10) NOT NULL
  );
