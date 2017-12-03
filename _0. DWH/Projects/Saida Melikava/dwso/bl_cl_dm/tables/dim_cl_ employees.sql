DROP TABLE Dim_Cl_Employees CASCADE CONSTRAINTS;
CREATE TABLE Dim_Cl_Employees
  (
    Employee_3nf_id               NUMBER(8),
    Employee_code                 VARCHAR2(8) ,
    Employee_surname              VARCHAR2(70) ,
    Employee_name                 VARCHAR2(70) ,
    Employee_phone                VARCHAR2(30) ,
    Employee_email                VARCHAR2(70) ,
    Employee_dep_id               NUMBER(8),
    Employee_department_name      VARCHAR2(70) ,
    Employee_manager_surname      VARCHAR2(70) ,
    Employee_manager_name         VARCHAR2(70) ,
    Employee_store_name           VARCHAR2(30) ,
    Employee_store_city_id        NUMBER(8) ,
    Employee_store_city           VARCHAR2(50) ,
    Employee_store_address_id     NUMBER(8) ,
    Employee_store_address_street VARCHAR2(50),
    Employee_store_address_house  VARCHAR2(50)
  ); 