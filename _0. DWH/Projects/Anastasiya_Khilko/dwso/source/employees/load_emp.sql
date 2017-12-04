set SERVEROUTPUT ON
begin
    pkg_load_3nf_emp.load_wrk_emp;
    pkg_load_3nf_emp.load_cls_emp;
    pkg_load_3nf_emp.load_ce_emp;
end;