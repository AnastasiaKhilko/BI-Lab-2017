SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_loc_types.load_cls_loc_types;
    bl_cl.pkg_load_3nf_loc_types.load_ce_loc_types;
END;