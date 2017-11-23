CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_customers;
						
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
                              first_name,
                              last_name,
                              age,
                              age_category_id,
                              email,
                              phone,
                              address,
                              city_id
                            )
SELECT passport_number as customer_id,
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
         city_id
  FROM wrk_customers wst left join wrk_cities wct on wst.city = wct.city_desc;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_customers;
---------------------------------------------------  
END pkg_etl_insert_customers;