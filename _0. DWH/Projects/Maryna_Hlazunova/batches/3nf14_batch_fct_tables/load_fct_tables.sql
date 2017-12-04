SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_facts.load_wrk_fct_orders;
    bl_cl.pkg_load_3nf_facts.load_cls_fct_orders;
    bl_cl.pkg_load_3nf_facts.load_ce_fct_orders;
    bl_cl.pkg_load_3nf_facts.load_cls_fct_items;
    bl_cl.pkg_load_3nf_facts.load_ce_fct_items;
END;

/*select count(*) from WRK_FCT_ORDERS;
select count(*) from CLS_FCT_ORDERS;
select count(*) from BL_3NF.CE_FCT_ORDERS;
select count(*) from CLS_FCT_ITEMS;
select count(*) from BL_3NF.CE_FCT_ITEMS; 
select * from BL_3NF.CE_FCT_ITEMS; */