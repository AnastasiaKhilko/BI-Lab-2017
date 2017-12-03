SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_localities.load_cls_localities;
    bl_cl.pkg_load_3nf_localities.load_ce_localities;
END;