CREATE OR REPLACE PACKAGE pkg_etl_insert 
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_stores;
  PROCEDURE insert_table_customers;
  PROCEDURE insert_table_employees;
  PROCEDURE insert_table_products;

END pkg_etl_insert;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert
AS
---------------------------------------------------
  PROCEDURE insert_table_stores
  IS
  BEGIN
    MERGE INTO dim_stores t USING
    ( SELECT *
      FROM bl_cl_1st.cls_stores
      MINUS
      SELECT * FROM dim_stores
    ) c ON ( c.store_surr_id = t.store_surr_id )
    WHEN matched THEN
    UPDATE SET t.update_dt = c.update_dt 
    WHEN NOT matched THEN
    INSERT
      (
        store_surr_ID ,
        store_ID ,
        store_desc,
        phone,
        address,
        city,
        country,
        insert_dt,
        update_dt
      )
      VALUES
      (
        c.store_surr_ID ,
        c.store_ID ,
        c.store_desc,
        c.phone,
        c.address,
        c.city,
        c.country,
        c.insert_dt,
        c.update_dt
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_stores;
---------------------------------------------------
  PROCEDURE insert_table_customers
  IS
  BEGIN
    MERGE INTO dim_customers_scd t USING
    ( SELECT *
      FROM bl_cl_1st.cls_customers
      MINUS
      SELECT * FROM dim_customers_scd
    ) c ON ( c.customer_surr_id = t.customer_surr_id )
    WHEN matched THEN
    UPDATE SET t.end_dt = c.end_dt 
    WHEN NOT matched THEN
    INSERT
      (
       customer_surr_id,
       customer_id, 
       first_name, 
       last_name, 
       age, 
       email, 
       phone, 
       address, 
       city, 
       country, 
       start_dt, 
       end_dt, 
       is_active
      )
      VALUES
      (
       c.customer_surr_id,
       c.customer_id, 
       c.first_name, 
       c.last_name, 
       c.age, 
       c.email, 
       c.phone, 
       c.address, 
       c.city, 
       c.country, 
       c.start_dt, 
       c.end_dt, 
       c.is_active
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_customers;
---------------------------------------------------
  PROCEDURE insert_table_employees
  IS
  BEGIN
    MERGE INTO dim_employees_scd t USING
    ( SELECT *
      FROM bl_cl_1st.cls_employees
      MINUS
      SELECT * FROM dim_employees_scd
    ) c ON ( c.employee_surr_id = t.employee_surr_id )
    WHEN matched THEN
    UPDATE SET t.end_dt = c.end_dt 
    WHEN NOT matched THEN
    INSERT
      (
       employee_surr_id,
       employee_id,
       employee_desc,
       first_name,
       last_name,
       position_name,
       email,
       phone,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       c.employee_surr_id,
       c.employee_id,
       c.employee_desc,
       c.first_name,
       c.last_name,
       c.position_name,
       c.email,
       c.phone,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_employees;
---------------------------------------------------
  PROCEDURE insert_table_products
  IS
  BEGIN
    MERGE INTO dim_products_scd t USING
    ( SELECT *
      FROM bl_cl_1st.cls_products
      MINUS
      SELECT * FROM dim_products_scd
    ) c ON ( c.product_surr_id = t.product_surr_id )
    WHEN matched THEN
    UPDATE SET t.end_dt = c.end_dt 
    WHEN NOT matched THEN
    INSERT
      (
       product_surr_id,
       product_id,
       product_desc,
       color,
       price,
       start_dt,
       end_dt,
       is_active
      )
      VALUES
      (
       c.product_surr_id,
       c.product_id,
       c.product_desc,
       c.color,
       c.price,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END insert_table_products;
---------------------------------------------------
  
END pkg_etl_insert;
