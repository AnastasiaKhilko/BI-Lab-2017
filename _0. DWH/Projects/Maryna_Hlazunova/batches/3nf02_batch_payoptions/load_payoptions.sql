SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_payoptions.load_wrk_payoptions;
    bl_cl.pkg_load_3nf_payoptions.load_cls_payoptions;
    bl_cl.pkg_load_3nf_payoptions.load_ce_payoptions;
END;