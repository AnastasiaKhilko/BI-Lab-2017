set SERVEROUTPUT ON
begin
    pkg_load_3nf_categories.load_wrk_products;
    pkg_load_3nf_categories.load_cls_product_categories;
    pkg_load_3nf_categories.load_ce_product_categories;
end;