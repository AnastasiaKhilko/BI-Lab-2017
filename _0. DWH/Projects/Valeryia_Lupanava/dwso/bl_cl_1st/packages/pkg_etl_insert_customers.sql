CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_customers;
  PROCEDURE merge_table_ce_customers;
						
END pkg_etl_insert_customers;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
---------------------------------------------------  
PROCEDURE insert_table_customers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
  INSERT INTO cls_customers (
                              customer_id,
                              customer_number,
                              first_name,
                              last_name,
                              age,
                              age_category_id,
                              email,
                              phone,
                              address,
                              city_id,
                              start_dt,
                              is_active
                            )
SELECT   cls_customers_seq.NEXTVAL AS customer_id,
         passport_number as customer_number,
         first_name,
         last_name,
         age,
         (case when age >= 18 and age <25 then 1
               when age >= 25 and age <35 then 2
               when age >= 35 and age <45 then 3
               when age >= 45 and age <55 then 4
               when age >= 55 then 5
          end) as age_category_id,
         email,
         phone,
         address,
         city_id,
         SYSDATE AS start_dt,
         'TRUE' AS is_active
  FROM wrk_customers wst inner join wrk_cities wct on wst.city = wct.city_desc;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_customers;
---------------------------------------------------  
---------------------------------------------------
PROCEDURE merge_table_ce_customers
IS
BEGIN

MERGE INTO bl_3nf.ce_customers t USING
    ( SELECT customer_id,
             customer_number,
             first_name,
             last_name,
             age,
             age_category_id,
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
             customer_number,
             first_name,
             last_name,
             age,
             age_category_srcid AS age_category_id,
             email,
             phone,
             address,
             city_srcid AS city_id,
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_customers
    ) c ON ( c.customer_id = t.customer_srcid )
    WHEN matched THEN
    UPDATE SET 
               t.customer_number  = c.customer_number,
               t.first_name  = c.first_name,
               t.last_name  = c.last_name,
               t.age  = c.age,
               t.age_category_srcid  = c.age_category_id,
               t.email  = c.email,
               t.phone  = c.phone,  
               t.address  = c.address,
               t.city_srcid  = c.city_id,
               t.start_dt  = c.start_dt,
               t.end_dt  = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        customer_id,
        customer_srcid,
        customer_number,
        first_name,
        last_name,
        age,
        age_category_srcid,
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
        c.customer_number,
        c.first_name,
        c.last_name,
        c.age,
        c.age_category_id,
        c.email,
        c.phone,
        c.address,
        c.city_id,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_table_ce_customers;
---------------------------------------------------
END pkg_etl_insert_customers;