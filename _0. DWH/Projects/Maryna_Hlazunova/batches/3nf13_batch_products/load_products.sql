SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_products.load_wrk_products;
    bl_cl.pkg_load_3nf_products.load_cls_colors;
    bl_cl.pkg_load_3nf_products.load_ce_colors;
    bl_cl.pkg_load_3nf_products.load_cls_products;
    bl_cl.pkg_load_3nf_products.load_ce_products;
END;