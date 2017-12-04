set SERVEROUTPUT ON
begin
    pkg_load_3nf_products.load_wrk_products1;
    pkg_load_3nf_products.load_cls_products;
    pkg_load_3nf_products.load_ce_products;
end;
