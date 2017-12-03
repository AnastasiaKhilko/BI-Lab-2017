SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_customers.load_wrk_customers;
    bl_cl.pkg_load_3nf_customers.load_wrk_customers2;
    bl_cl.pkg_load_3nf_customers.load_cls_customers;
    bl_cl.pkg_load_3nf_customers.load_ce_customers;
END;