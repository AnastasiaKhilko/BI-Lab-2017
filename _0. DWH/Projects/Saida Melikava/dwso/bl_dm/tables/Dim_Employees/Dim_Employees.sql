DROP TABLE Dim_Employees CASCADE CONSTRAINTS;
CREATE TABLE Dim_Employees
  (
    Employee_sur_id               NUMBER(8) PRIMARY KEY,
    Employee_3nf_id               NUMBER(8)NOT NULL,
    Employee_code                 VARCHAR2(8) NOT NULL,
    Employee_surname              VARCHAR2(70) NOT NULL,
    Employee_name                 VARCHAR2(80) NOT NULL,
    Employee_phone                VARCHAR2(30) NOT NULL,
    Employee_email                VARCHAR2(70) NOT NULL,
    Employee_dep_id               NUMBER(8)NOT NULL,
    Employee_department_name      VARCHAR2(120) NOT NULL,
    Employee_manager_surname      VARCHAR2(70) NOT NULL,
    Employee_manager_name         VARCHAR2(70) NOT NULL,
    Employee_store_name           VARCHAR2(30) NOT NULL,
    Employee_store_city_id        NUMBER(8) NOT NULL,
    Employee_store_city           VARCHAR2(50) NOT NULL,
    Employee_store_address_id     NUMBER(8) NOT NULL,
    Employee_store_address_street VARCHAR2(80) NOT NULL,
    Employee_store_address_house  VARCHAR2(50) NOT NULL,
    insert_DT                     DATE DEFAULT(sysdate) NOT NULL ,
    update_DT                     DATE DEFAULT(sysdate) NOT NULL
  );
COMMENT ON TABLE Dim_Employees
IS
  'Table Content: All information about employees of the company.   
Refresh Cycle/Window: Data is loaded every 2 weeks and for a long period of time.  
';
  COMMENT ON column Dim_Employees.Employee_sur_id
IS
  'Dimension surrogate key';
  COMMENT ON column Dim_Employees.Employee_code
IS
  'Dimension business key, comes from external system.';
