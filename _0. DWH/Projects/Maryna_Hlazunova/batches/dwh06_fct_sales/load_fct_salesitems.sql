SET SERVEROUTPUT ON

BEGIN
    bl_cl_dwh.pkg_load_fct_salesitems.load_cls2_fct_salesitems;
    bl_cl_dwh.pkg_load_fct_salesitems.load_fct_salesitems;
END;

--select count(*) from cls2_fct_salesitems;
--select count(*) from bl_dwh.fct_salesitems;