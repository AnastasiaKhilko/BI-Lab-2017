connect BL_CL/123456;
show user;
@D:\epam\dwh\source\fact_table\create_wrk_fct_sales.sql
@D:\epam\dwh\source\fact_table\create_cls_fct_sales.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\fact_table\create_ce_fct_sales.sql
@D:\epam\dwh\source\fact_table\grant_ce_fact_to_bl_cl.sql
@D:\epam\dwh\source\fact_table\seq_fct_sales.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\fact_table\pkg_load_facts_def.sql
@D:\epam\dwh\source\fact_table\pkg_load_facts_impl.sql
@D:\epam\dwh\source\fact_table\load_fct_sales.sql