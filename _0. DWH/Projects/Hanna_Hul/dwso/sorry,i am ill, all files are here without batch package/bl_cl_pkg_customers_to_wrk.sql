CREATE OR REPLACE PACKAGE pkg_etl_load_wrk AS

    PROCEDURE load_wrk_prod_types;
 

END pkg_etl_load_wrk;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_wrk AS

    PROCEDURE load_wrk_prod_types
        IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wrk_customers';
        INSERT INTO wrk_customers SELECT
            *
        FROM
            sa_src.ext_customers;
            
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_wrk_prod_types;
END pkg_etl_load_wrk;
/
commit;