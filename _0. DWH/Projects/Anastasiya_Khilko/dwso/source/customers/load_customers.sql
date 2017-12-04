set SERVEROUTPUT ON
begin
    pkg_load_3nf_customers.load_wrk_customers;
    pkg_load_3nf_customers.load_cls_customers;
    pkg_load_3nf_customers.load_ce_customers;
end;