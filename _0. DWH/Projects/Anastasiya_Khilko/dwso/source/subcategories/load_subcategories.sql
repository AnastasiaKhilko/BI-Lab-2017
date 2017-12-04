set SERVEROUTPUT ON
begin
    --pkg_load_3nf_subcategories.load_wrk_products;
    pkg_load_3nf_subcategories.load_cls_product_subcategories;
    pkg_load_3nf_subcategories.load_ce_product_subcategories;
end;

