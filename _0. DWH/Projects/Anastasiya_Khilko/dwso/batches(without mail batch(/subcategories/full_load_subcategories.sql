/*connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\products\ext_products.sql
@D:\epam\dwh\source\products\grant_ext_products_to_bl_cl.sql*/


connect BL_CL/123456;
show user;
--@D:\epam\dwh\source\products\wrk_products.sql
@D:\epam\dwh\source\subcategories\cls_product_subcategories.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\subcategories\ce_product_subcategories.sql
@D:\epam\dwh\source\subcategories\grant_ce_sub_to_bl_cl.sql
@D:\epam\dwh\source\subcategories\seq_subcategories.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\subcategories\pkg_load_3nf_subcat_def.sql
@D:\epam\dwh\source\subcategories\pkg_load_3nf_subcut_impl.sql
@D:\epam\dwh\source\subcategories\load_subcategories.sql
