SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_pickuppoints.load_wrk_pickuppoints;
    bl_cl.pkg_load_3nf_pickuppoints.load_cls_pickuppoints;
    bl_cl.pkg_load_3nf_pickuppoints.load_ce_pickuppoints;
END;