connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\customers\ext_customers.sql
@D:\epam\dwh\source\customers\grant_ext_customers_to_bl_cl.sql


connect BL_CL/123456;
show user;
@D:\epam\dwh\source\customers\wrk_customers.sql
@D:\epam\dwh\source\customers\cls_customers.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\customers\ce_customers.sql
@D:\epam\dwh\source\customers\grant_ce_cust_to_bl_cl.sql
@D:\epam\dwh\source\customers\seq_customers.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\customers\pkg_load_3nf_customers_def.sql
@D:\epam\dwh\source\customers\pkg_load_3nf_customers_impl.sql
@D:\epam\dwh\source\customers\load_customers.sql
