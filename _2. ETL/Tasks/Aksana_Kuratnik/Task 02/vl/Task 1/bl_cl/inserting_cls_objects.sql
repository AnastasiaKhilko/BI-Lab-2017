-- Filling tables.
-- Customers.

INSERT INTO CLS_CUSTOMERS
SELECT cls_customers_val.NEXTVAL as customer_surr_id, 
       passport_number as customer_id, 
       first_name,
       last_name,
       age,
       email,
       phone,
       address,
       city,
       country,
       SYSDATE as start_dt,
       '-99' as end_dt,
       is_active
FROM   wrk_customers;

-- Employees.

INSERT INTO CLS_EMPLOYEES
SELECT cls_employees_val.NEXTVAL as employee_surr_id, 
       employee_code as employee_id, 
       position_grade_srcid as employee_desc, 
       first_name,
       last_name,
       position_name,
       email,
       phone,
       start_date as start_dt,
       end_date as end_dt,
       is_active
FROM   wrk_employees;

-- Products.

INSERT INTO CLS_PRODUCTS
SELECT cls_products_val.NEXTVAL as product_surr_id, 
       product_id, 
       product_desc, 
       color,
       price,
       start_dt,
       end_dt,
       is_active
FROM   wrk_products;

-- Stores.

INSERT INTO CLS_STORES
SELECT cls_stores_val.NEXTVAL as store_surr_id,
       store_id, 
       store_desc, 
       phone,
       address,
       city,
       country,
       insert_dt,
       update_dt
FROM   wrk_stores;