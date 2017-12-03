SET SERVEROUTPUT ON

BEGIN
    bl_cl_dwh.pkg_load_dim_pickuppoints.load_cls2_pickuppoints;
    bl_cl_dwh.pkg_load_dim_pickuppoints.load_dim_pickuppoints;
END;