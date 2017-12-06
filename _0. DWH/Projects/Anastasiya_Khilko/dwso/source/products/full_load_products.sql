
connect BL_CL/123456;
show user;
@wrk_products1.sql
@cls_products.sql

connect BL_3NF/54321;
show user;
@ce_products.sql
@grant_ce_prod_to_bl_cl.sql
@seq_products.sql

connect BL_CL/123456;
show user;
@pkg_load_3nf_products_def.sql
@pkg_load_3nf_products.sql
@load_products.sql

/*connect BL_CL/123456;
show user;
@D:\epam\dwh\source\products\wrk_products1.sql
@D:\epam\dwh\source\products\cls_products.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\products\ce_products.sql
@D:\epam\dwh\source\products\grant_ce_prod_to_bl_cl.sql
@D:\epam\dwh\source\products\seq_products.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\products\pkg_load_3nf_products_def.sql
@D:\epam\dwh\source\products\pkg_load_3nf_products.sql
@D:\epam\dwh\source\products\load_products.sql*/