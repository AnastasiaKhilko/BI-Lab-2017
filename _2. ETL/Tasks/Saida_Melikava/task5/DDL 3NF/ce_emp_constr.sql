ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_store FOREIGN KEY (employee_store_id) REFERENCES ce_stores(store_id);
ALTER TABLE ce_stores ADD CONSTRAINT fk_store_manag FOREIGN KEY (store_manager_id) REFERENCES ce_employees(employee_id);
ALTER TABLE ce_stores ADD CONSTRAINT fk_store_address FOREIGN KEY (store_address_id) REFERENCES ce_addr(addr_id);
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_dep FOREIGN KEY (Employee_dep_id ) REFERENCES ce_departments(department_id);
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_manager FOREIGN KEY (Employee_manager_id) REFERENCES ce_employees(employee_id);