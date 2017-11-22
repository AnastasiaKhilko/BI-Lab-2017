CREATE OR REPLACE PACKAGE pkg_etl_load_wrk AS
  /**===============================================*\
  Name...............:   pkg_etl_load_wrk
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   21-Nov-2017
  \*=============================================== */
  /****************************************************/

  /* Loads cleansisng tables for geo structure */
    PROCEDURE load_wrk_prod_types;

    PROCEDURE load_wrk_brands;
    
    PROCEDURE load_wrk_products;
    
    PROCEDURE load_wrk_delivery_payment;
    
    PROCEDURE load_wrk_locations;
    
    PROCEDURE load_wrk_pickuppoints;
    
    PROCEDURE load_wrk_customers;   

END pkg_etl_load_wrk;
/