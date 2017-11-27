EXECUTE pckg_drop.drop_proc(object_name=>'Dim_Employees_SCD',object_type=>'table');
CREATE TABLE Dim_Employees_SCD
  (
    Employee_id              NUMBER(8) PRIMARY KEY,
    Employee_code            VARCHAR2(8) NOT NULL,
    Employee_name            VARCHAR2(30) NOT NULL,
    Employee_surname         VARCHAR2(30) NOT NULL,
    Employee_email           VARCHAR2(50) NOT NULL,
    Employee_phone           VARCHAR2(30) NOT NULL,
    Employee_department_name VARCHAR2(30) NOT NULL,
    Employee_manager_id      NUMBER(8) NOT NULL,
    Employee_manager_name    VARCHAR2(70) NOT NULL,
    Employee_store_id        NUMBER(8) NOT NULL,
    Employee_store_name      VARCHAR2(30) NOT NULL,
    Employee_store_city      VARCHAR2(50) NOT NULL,
    Employee_store_address   VARCHAR2(50) NOT NULL,
    Start_DT                 DATE NOT NULL,
    End_DT                   DATE NOT NULL,
    Is_active                VARCHAR2(4) NOT NULL,
    Insert_DT                DATE NOT NULL
  );
COMMENT ON TABLE Dim_Employees_SCD
IS
  'Table Content: All information about employees of the company.   
Refresh Cycle/Window: Data is loaded every 2 weeks and for a long period of time.  
';
  COMMENT ON column Dim_Employees_SCD.Employee_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Employees_SCD.Employee_code
IS
  'Dimension business key, comes from external system.';
  COMMENT ON column Dim_Employees_SCD.Employee_manager_id
IS
  'Employee_id of a manager if additional join is needed.';
  COMMENT ON column Dim_Employees_SCD.Employee_Store_id
IS
  'ID on store if additional join is needed.';
  COMMENT ON column Dim_Employees_SCD.Start_DT
IS
  'When started to function.';
  COMMENT ON column Dim_Employees_SCD.End_DT
IS
  'IWhen ended to function.';
  COMMENT ON column Dim_Employees_SCD.Is_Active
IS
  'Active(Y) or Not(Y).';
  COMMENT ON column Dim_Employees_SCD.Insert_DT
IS
  'When data was loaded';
  /*
  GRANT SELECT ON dim_template TO some_user;*/
