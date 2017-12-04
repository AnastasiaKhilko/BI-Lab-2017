set SERVEROUTPUT ON
begin
    pkg_load_3nf_providers.load_wrk_providers;
    pkg_load_3nf_providers.load_cls_providers;
    pkg_load_3nf_providers.load_ce_providers;
end;