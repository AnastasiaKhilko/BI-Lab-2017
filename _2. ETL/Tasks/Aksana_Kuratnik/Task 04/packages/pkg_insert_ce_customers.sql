CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_customers;
						
END pkg_etl_insert_customers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS 
PROCEDURE merge_ce_customers
IS
BEGIN

MERGE INTO bl_3nf.ce_customers t USING
    ( SELECT customer_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             city_id,
             start_dt,
             end_dt,
             is_active
      FROM   cls_customers
    MINUS
      SELECT customer_srcid AS customer_id,
             first_name,
             last_name,
             age,
             email,
             phone,
             address,
             city_srcid AS city_id,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_customers
    ) c ON ( c.customer_id = t.customer_srcid
       AND   c.first_name = t.first_name
       AND   c.last_name = t.last_name
       AND   c.age = t.age
       AND   c.email = t.email
       AND   c.phone = t.phone
       AND   c.address = t.address
       AND   t.city_srcid  = c.city_id
       AND   c.start_dt = t.start_dt)
    WHEN MATCHED THEN 
    UPDATE SET
       t.end_dt  = c.end_dt,
       t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        customer_id,
        customer_srcid,
        first_name,
        last_name,
        age,
        email,
        phone,
        address,
        city_srcid,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_customers_seq.NEXTVAL,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.age,
        c.email,
        c.phone,
        c.address,
        c.city_id,
        c.start_dt,
        c.end_dt,
        'TRUE'
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_customers;
END pkg_etl_insert_customers;
/