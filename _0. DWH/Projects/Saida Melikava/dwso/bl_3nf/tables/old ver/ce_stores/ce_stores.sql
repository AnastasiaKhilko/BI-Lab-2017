CREATE TABLE ce_stores
  (
    Store_code         VARCHAR2(8) PRIMARY KEY,
    Store_name         VARCHAR2(30) NOT NULL,
    Store_email        VARCHAR2(50) NOT NULL,
    Store_phone        VARCHAR2(30) NOT NULL,
    Store_Manager_code VARCHAR2(30) NOT NULL,
    Store_address_id   NUMBER(8) NOT NULL,
    insert_DT          DATE NOT NULL,
    update_DT          DATE NOT NULL,
    CONSTRAINT fk_store_manag FOREIGN KEY (store_Manager_code) REFERENCES ce_employees(employee_code),
    CONSTRAINT fk_store_address FOREIGN KEY (store_address_id) REFERENCES ce_addresses(address_id)
  );
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_store FOREIGN KEY (employee_store_code) REFERENCES ce_stores(store_code);
