BEGIN
    pkg_insert_wrk.insert_wrk_customers;

    pkg_insert_wrk.insert_wrk_employees;
   
    pkg_insert_wrk.insert_wrk_addresses;
    
    pkg_insert_wrk.insert_wrk_product_hierarchy;
 
    pkg_insert_wrk.insert_wrk_product_information;
   
   pkg_insert_wrk.insert_wrk_provid_information;
     
END;