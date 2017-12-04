CREATE OR REPLACE PACKAGE pkg_etl_load_cl_customers AS
       PROCEDURE load_cl_customers;
	   PROCEDURE load_cl_country;
END pkg_etl_load_cl_customers;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_customers
AS
  PROCEDURE load_cl_customers
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_customers';
   INSERT
INTO cl_customers
  (
    customer_code,
    name,
    surname,
    age,       
    gender,  
    phone,
    email  
  )
SELECT DISTINCT customer_id as customer_code,
	   name as first_name,
	   surname as last_name,
	   age as age,       
	   gender as gender,  
	   phone as phone,
	   email as email
FROM wrk_customers;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_customers;
  ----------------------------------------
  PROCEDURE load_cl_country
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_country';
    INSERT INTO cl_country
  (
    country_name
  )
    SELECT distinct country as country_name
	FROM wrk_seller
  UNION
  Select distinct country from wrk_shops;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_country;
  END pkg_etl_load_cl_customers;
/
