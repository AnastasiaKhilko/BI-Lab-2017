create or replace package body pkg_insert_wrk as
    
    procedure insert_wrk_customers
     IS
        begin
            execute immediate 'truncate table wrk_customers';
            insert into wrk_customers 
            select * from sa_src.ext_customers;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_customers;
        
    procedure insert_wrk_employees
     IS
        begin
            execute immediate 'truncate table wrk_employees';
            insert into wrk_employees 
            select * from sa_src.ext_employees;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_employees;
        
    procedure insert_wrk_addresses
     IS
        begin
            execute immediate 'truncate table wrk_addresses';
            insert into wrk_addresses 
            select * from sa_src.ext_addresses;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_addresses;

    procedure insert_wrk_product_hierarchy
     IS
        begin
            execute immediate 'truncate table wrk_product_hierarchy';
            insert into wrk_product_hierarchy 
            select * from sa_src.ext_product_hierarchy;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_product_hierarchy;
        
   procedure insert_wrk_product_information
     IS
        begin
            execute immediate 'truncate table wrk_product_information';
            insert into wrk_product_information
            select * from sa_src.ext_product_information;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_product_information;
        
    procedure insert_wrk_provid_information
      IS
        begin
            execute immediate 'truncate table wrk_provider_information';
            insert into wrk_provider_information
            select * from sa_src.ext_provider_information;
            commit;
        EXCEPTION
            when others then
                raise;
        END insert_wrk_provid_information;
END pkg_insert_wrk;
/
    
