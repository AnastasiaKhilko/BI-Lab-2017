SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_brands.load_wrk_brands;
    bl_cl.pkg_load_3nf_brands.load_cls_brands;
    bl_cl.pkg_load_3nf_brands.load_ce_brands;
END;