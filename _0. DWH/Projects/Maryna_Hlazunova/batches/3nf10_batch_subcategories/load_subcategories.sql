SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_subcategories.load_cls_subcategories;
    bl_cl.pkg_load_3nf_subcategories.load_ce_subcategories;
END;