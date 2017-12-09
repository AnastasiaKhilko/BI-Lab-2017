CREATE OR REPLACE PACKAGE pkg_etl_insert_customers
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_customers;
END pkg_etl_insert_customers;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_customers
AS
---------------------------------------------------  
PROCEDURE insert_cls_customers
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_customers');
  BEGIN
    INSERT INTO cls_customers
    SELECT --+PARALLEL(4)
           DISTINCT
           customer_id AS customer_surr_id,
           customer_srcid AS customer_surr_id,
           first_name,
           last_name,
           age,
           email,
           phone,
           address,
           cs.city_desc AS city,
           cn.country_desc AS country,
           cr.region_desc AS region,
           start_dt,
           end_dt,
           is_active
    FROM   bl_3nf.ce_customers cc left join bl_3nf.ce_cities cs
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

END insert_cls_customers;
END pkg_etl_insert_customers;
/