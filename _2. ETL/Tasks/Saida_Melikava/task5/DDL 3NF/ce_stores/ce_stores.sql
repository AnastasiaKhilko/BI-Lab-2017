EXECUTE pckg_drop.drop_proc(object_name=>'ce_stores', object_type=>'table');
CREATE TABLE ce_stores
  (
    Store_id         NUMBER(8) PRIMARY KEY,
    Store_code       VARCHAR2(30) NOT NULL,
    Store_name       VARCHAR2(30) NOT NULL,
    Store_phone      VARCHAR2(30) NOT NULL,
    Store_manager_id NUMBER(8) NOT NULL,
    Store_address_id NUMBER(8) NOT NULL,
    start_DT            DATE DEFAULT(to_date('01-JAN-1900')) NOT NULL,
    end_DT              DATE DEFAULT(to_date('31-DEC-9999')) NOT NULL,
    is_active AS (
    CASE
      WHEN end_dt=to_date('31-DEC-9999')
      THEN 'Y'
      ELSE 'N'
    END) ,
    insert_DT DATE DEFAULT(sysdate) NOT NULL
  );
ALTER TABLE ce_stores ADD CONSTRAINT fk_store_manag FOREIGN KEY (store_manager_id) REFERENCES ce_employees(employee_id);
ALTER TABLE ce_stores ADD CONSTRAINT fk_store_address FOREIGN KEY (store_address_id) REFERENCES ce_addr(addr_id);
ALTER TABLE ce_employees ADD CONSTRAINT fk_emp_store FOREIGN KEY (employee_store_id) REFERENCES ce_stores(store_id);
