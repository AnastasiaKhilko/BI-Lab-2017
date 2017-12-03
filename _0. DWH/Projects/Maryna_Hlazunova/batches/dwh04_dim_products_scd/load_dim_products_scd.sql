SET SERVEROUTPUT ON

BEGIN
    bl_cl_dwh.pkg_load_dim_products.load_cls2_products;
    bl_cl_dwh.pkg_load_dim_products.load_dim_products_scd;
END;

--select count(*) from bl_dwh.dim_products_scd;