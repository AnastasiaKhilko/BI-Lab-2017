SET SERVEROUTPUT ON

BEGIN
    bl_cl_dwh.pkg_load_dim_customers.load_cls2_customers;
    bl_cl_dwh.pkg_load_dim_customers.load_dim_customers_scd;
END;

--select count(*) from cls2_customers;