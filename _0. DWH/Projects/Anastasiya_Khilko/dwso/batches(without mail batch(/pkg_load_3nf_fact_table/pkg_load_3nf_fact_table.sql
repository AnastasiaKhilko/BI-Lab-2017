CREATE OR REPLACE PACKAGE pkg_load_3nf_fact_table AS

    PROCEDURE load_wrk_fct_sales;    
    
    PROCEDURE load_cls_fct_sales;
    
    PROCEDURE load_ce_fct_sales;

END pkg_load_3nf_fact_table;
/