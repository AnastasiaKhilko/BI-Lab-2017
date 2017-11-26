CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_customers;
  PROCEDURE merge_table_customers;
						
END pkg_etl_insert_customers;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
---------------------------------------------------  
PROCEDURE insert_table_customers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers_scd');
  BEGIN
    INSERT INTO cls_customers_scd
    SELECT DISTINCT
           customer_srcid AS customer_surr_id,
           customer_number AS customer_id,
           first_name,
           last_name,
           age,
           ac.age_category_desc AS age_category,
           email,
           phone,
           address,
           cs.city_desc AS city,
           cn.country_desc AS country,
           cr.region_desc AS region,
           start_dt,
           end_dt,
           is_active
    FROM   bl_3nf.ce_customers cc left join bl_3nf.ce_age_categories ac
                                         on cc.age_category_srcid = ac.age_category_srcid
                                  left join bl_3nf.ce_cities cs
                                         on cc.city_srcid = cs.city_srcid
                                  left join bl_3nf.ce_countries cn
                                         on cs.country_srcid = cn.country_srcid
                                  left join bl_3nf.ce_regions cr
                                         on cn.region_srcid = cr.region_srcid;
      
      END;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_customers;
--------------------------------------------------- 
PROCEDURE merge_table_customers
IS
BEGIN
  MERGE INTO bl_dm.dim_customers_scd t USING
    ( SELECT *
      FROM   cls_customers_scd
    MINUS
      SELECT *          
      FROM   bl_dm.dim_customers_scd
    ) c ON ( c.customer_surr_id = t.customer_surr_id )
    WHEN matched THEN
    UPDATE SET t.customer_id = c.customer_id 
    WHEN NOT matched THEN
    INSERT
      (
       customer_surr_id,
       customer_id,
       first_name,
       last_name,
       age,
       age_category,
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
       c.customer_surr_id,
       c.customer_id,
       c.first_name,
       c.last_name,
       c.age,
       c.age_category,
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

END merge_table_customers;
--------------------------------------------------- 
END pkg_etl_insert_customers;