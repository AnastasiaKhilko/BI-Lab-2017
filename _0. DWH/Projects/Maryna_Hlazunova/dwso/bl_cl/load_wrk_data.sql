SET SERVEROUTPUT ON

BEGIN
-- Load 
    pkg_etl_load_wrk.load_wrk_prod_types;
-- Load 
    pkg_etl_load_wrk.load_wrk_brands;
-- Load    
    pkg_etl_load_wrk.load_wrk_products;
-- Load     
    pkg_etl_load_wrk.load_wrk_delivery_payment;
-- Load     
    pkg_etl_load_wrk.load_wrk_locations;
-- Load     
    pkg_etl_load_wrk.load_wrk_pickuppoints;
-- Load     
    pkg_etl_load_wrk.load_wrk_customers;   
END;