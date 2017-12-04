SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_categories.load_wrk_refer_products;
    bl_cl.pkg_load_3nf_categories.load_cls_categories;
    bl_cl.pkg_load_3nf_categories.load_ce_categories;
END;