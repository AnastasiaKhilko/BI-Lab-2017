set SERVEROUTPUT ON
begin
    pkg_load_3nf_stores.load_wrk_stores;
    pkg_load_3nf_stores.load_cls_stores;
    pkg_load_3nf_stores.load_ce_stores;
end;