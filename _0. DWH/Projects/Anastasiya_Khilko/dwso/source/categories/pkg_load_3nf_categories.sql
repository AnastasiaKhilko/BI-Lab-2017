CREATE OR REPLACE PACKAGE pkg_load_3nf_categories AS
    PROCEDURE load_wrk_products;

    PROCEDURE load_cls_product_categories;
    
    PROCEDURE load_ce_product_categories;

END pkg_load_3nf_categories;
/