SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_deliveries.load_wrk_deliveries;
    bl_cl.pkg_load_3nf_deliveries.load_cls_deliveries;
    bl_cl.pkg_load_3nf_deliveries.load_ce_deliveries;
END;