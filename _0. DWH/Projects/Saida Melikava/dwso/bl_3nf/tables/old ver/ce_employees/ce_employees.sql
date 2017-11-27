CREATE TABLE ce_employees
  (
    Employee_code         VARCHAR2(8) PRIMARY KEY,
    Employee_name         VARCHAR2(30) NOT NULL,
    Employee_surname      VARCHAR2(30) NOT NULL,
    Employee_email        VARCHAR2(50) NOT NULL,
    Employee_phone        VARCHAR2(30) NOT NULL,
    Employee_dep_id       NUMBER(8) NOT NULL,
    Employee_manager_code VARCHAR2(8),
    Employee_store_code   VARCHAR2(8) NOT NULL,
    start_DT              DATE NOT NULL,
    end_DT                DATE NOT NULL,
    is_active             VARCHAR2(4) NOT NULL,
    insert_DT             DATE NOT NULL,
    CONSTRAINT fk_emp_dep FOREIGN KEY (Employee_dep_id ) REFERENCES ce_departments(department_id),
    CONSTRAINT fk_emp_manager FOREIGN KEY (Employee_manager_code) REFERENCES ce_employees(employee_code)
  );
