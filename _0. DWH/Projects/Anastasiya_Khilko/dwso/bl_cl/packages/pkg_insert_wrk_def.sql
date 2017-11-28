create or replace package pkg_insert_wrk
AUTHID current_user as

    PROCEDURE insert_wrk_customers;

    PROCEDURE insert_wrk_employees;
    
    PROCEDURE insert_wrk_addresses;
    
    PROCEDURE insert_wrk_product_hierarchy;
    
    PROCEDURE insert_wrk_product_information;
    
    PROCEDURE insert_wrk_provid_information;
        
end pkg_insert_wrk;
/