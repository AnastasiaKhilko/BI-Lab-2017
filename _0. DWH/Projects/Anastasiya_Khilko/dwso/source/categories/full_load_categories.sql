connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\categories\ext_products.sql
@D:\epam\dwh\source\categories\grant_ext_products_to_bl_cl.sql


connect BL_CL/123456;
show user;
@D:\epam\dwh\source\categories\wrk_products.sql
@D:\epam\dwh\source\categories\cls_product_categories.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\categories\ce_product_categories.sql
@D:\epam\dwh\source\categories\grant_ce_tables_to_bl_cl.sql
@D:\epam\dwh\source\categories\seq_categories.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\categories\pkg_load_3nf_categories.sql
@D:\epam\dwh\source\categories\pkg_load_3nf_categories_impl.sql
@D:\epam\dwh\source\categories\load_categories.sql
