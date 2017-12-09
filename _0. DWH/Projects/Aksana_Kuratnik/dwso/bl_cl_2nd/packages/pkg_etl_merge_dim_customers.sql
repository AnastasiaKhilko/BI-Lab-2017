CREATE OR REPLACE PACKAGE pkg_etl_merge_customers
AUTHID CURRENT_USER
AS
  PROCEDURE merge_dim_customers;						
END pkg_etl_merge_customers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_merge_customers
AS
PROCEDURE merge_dim_customers
IS
BEGIN
  MERGE INTO bl_dm.dim_customers t USING
    ( SELECT customer_surr_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             city,
             country,
             region,
             start_dt,
             end_dt,
             is_active 
      FROM   cls_customers
    MINUS
      SELECT customer_id AS customer_surr_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             city,
             country,
             region,
             start_dt,
             end_dt,
             is_active           
      FROM   bl_dm.dim_customers
    ) c ON (  
             t.first_name = c.first_name
       AND   t.last_name = c.last_name
       AND   t.age = c.age
       AND   t.email = c.email
       AND   t.phone = c.phone
       AND   t.address = c.address
       AND   t.city = c.city
       AND   t.country = c.country
       AND   t.region = c.region
       AND   t.start_dt = c.start_dt)
    WHEN matched THEN
    UPDATE SET 
               t.customer_id = c.customer_surr_id,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
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
       region,
       start_dt,
       end_dt,
       is_active 
      )
      VALUES
      (
       bl_dm.dim_customers_seq.NEXTVAL,
       c.customer_surr_id,
       c.first_name,
       c.last_name,
       c.age,
       c.email,
       c.phone,
       c.address,
       c.city,
       c.country,
       c.region,
       c.start_dt,
       c.end_dt,
       c.is_active
      ) ;
    COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END merge_dim_customers; 
END pkg_etl_merge_customers;
/