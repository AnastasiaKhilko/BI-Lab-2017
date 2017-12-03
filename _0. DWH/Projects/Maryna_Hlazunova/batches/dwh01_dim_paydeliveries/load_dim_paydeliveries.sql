SET SERVEROUTPUT ON

BEGIN
    bl_cl_dwh.pkg_load_dim_paydeliveries.load_cls2_paydeliveries;
    bl_cl_dwh.pkg_load_dim_paydeliveries.load_dim_paydeliveries;
END;