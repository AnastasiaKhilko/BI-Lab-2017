SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_types.load_cls_types;
    bl_cl.pkg_load_3nf_types.load_ce_types;
END;