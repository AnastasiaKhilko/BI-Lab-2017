CREATE OR REPLACE PACKAGE BODY pkg_etl_load_wrk AS
  /**===============================================*\
  Name...............:   pkg_etl_load_cls
  Contents...........:   Package description
  Author.............:   Maryna Hlazunova
  Date...............:   22-Nov-2017
  \*=============================================== */
  /****************************************************/

    PROCEDURE load_wrk_prod_types
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_prod_types';
        INSERT INTO wrk_prod_types SELECT
            *
        FROM
            sa_src.ext_prod_types;
            
        commit;

        dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_prod_types;
/****************************************************/
    PROCEDURE load_wrk_brands
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_brands';
        INSERT INTO wrk_brands SELECT
            *
        FROM
            sa_src.ext_brands;
            
        commit;

        dbms_output.put_line('The data in the table WRK_BRANDS is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_brands;
/****************************************************/
    PROCEDURE load_wrk_products
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_products';
        INSERT INTO wrk_products SELECT
            *
        FROM
            sa_src.ext_products;
            
        commit;

        dbms_output.put_line('The data in the table WRK_PRODUCTS is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_products;
/****************************************************/
    PROCEDURE load_wrk_delivery_payment
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_delivery_payment';
        INSERT INTO wrk_delivery_payment SELECT
            *
        FROM
            sa_src.ext_delivery_payment;
            
        commit;

        dbms_output.put_line('The data in the table WRK_DELIVERY_PAYMENT is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_delivery_payment;
/****************************************************/
    PROCEDURE load_wrk_locations
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_locations';
        INSERT INTO wrk_locations SELECT
            *
        FROM
            sa_src.ext_locations;
            
        commit;

        dbms_output.put_line('The data in the table WRK_LOCATIONS is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_locations;
/****************************************************/
    PROCEDURE load_wrk_pickuppoints
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_pickuppoints';
        INSERT INTO wrk_pickuppoints SELECT
            *
        FROM
            sa_src.ext_pickuppoints;
            
        commit;

        dbms_output.put_line('The data in the table WRK_PICKUPPOINTS is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_pickuppoints;
/****************************************************/
    PROCEDURE load_wrk_customers
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_customers SELECT
            *
        FROM
            sa_src.ext_customers;
            
        commit;

        dbms_output.put_line('The data in the table WRK_CUSTOMERS is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_customers;
/****************************************************/
END pkg_etl_load_wrk;
/