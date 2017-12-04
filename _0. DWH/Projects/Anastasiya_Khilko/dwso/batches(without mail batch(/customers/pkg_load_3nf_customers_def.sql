CREATE OR REPLACE PACKAGE pkg_load_3nf_customers AS
    PROCEDURE load_wrk_customers;

    PROCEDURE load_cls_customers;
    
    PROCEDURE load_ce_customers;

END pkg_load_3nf_customers;
/