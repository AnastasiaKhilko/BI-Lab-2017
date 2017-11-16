CREATE TABLE ce_employee
  (
    Employee_id         VARCHAR2(8) PRIMARY KEY,
    Employee_name       VARCHAR2(30) NOT NULL,
    Employee_surname    VARCHAR2(30) NOT NULL,
    Employee_email      VARCHAR2(50) NOT NULL,
    Employee_phone      VARCHAR2(30) NOT NULL,
    Employee_age        NUMBER(3) NOT NULL,
    Employee_manager_id VARCHAR2(8),
    Employee_dep_id     NUMBER(8) NOT NULL,
    Store_id            VARCHAR2(8) NOT NULL,
    employee_change_id  VARCHAR2(15),
    CONSTRAINT fk_emp_manager FOREIGN KEY (Employee_manager_id) REFERENCES ce_employee(employee_id),
    CONSTRAINT fk_emp_dep FOREIGN KEY (Employee_dep_id ) REFERENCES ce_department(dep_id),
    CONSTRAINT fk_emp_store FOREIGN KEY (Store_id) REFERENCES ce_store(store_id),
    CONSTRAINT fk_emp_change FOREIGN KEY ( Employee_change_id) REFERENCES ce_Employee_change(Employee_change_id)
  );
