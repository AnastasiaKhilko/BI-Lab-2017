EXECUTE pckg_drop.drop_proc(object_name=>'ce_employees', object_type=>'table');
CREATE TABLE ce_employees
  (
    Employee_id         NUMBER(8) PRIMARY KEY,
    Employee_code       VARCHAR2(8),
    Employee_surname    VARCHAR2(100) NOT NULL,
    Employee_name       VARCHAR2(100) NOT NULL,
    Employee_phone      VARCHAR2(30) NOT NULL,
    Employee_email      VARCHAR2(100) NOT NULL,
    Employee_dep_id     NUMBER(8) NOT NULL,
    Employee_manager_id NUMBER(8),
    Employee_store_id   NUMBER(8) NOT NULL,
    insert_DT        	DATE DEFAULT(sysdate) NOT NULL ,
    update_DT        	DATE DEFAULT(sysdate) NOT NULL
  );
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_dep FOREIGN KEY (Employee_dep_id ) REFERENCES ce_departments(department_id);
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_manager FOREIGN KEY (Employee_manager_id) REFERENCES ce_employees(employee_id);
