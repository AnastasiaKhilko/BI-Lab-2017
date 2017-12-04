connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\stores\ext_stores.sql
@D:\epam\dwh\source\stores\grant_ext_stores_to_bl_cl.sql


connect BL_CL/123456;
show user;
@D:\epam\dwh\source\stores\wrk_storess.sql
@D:\epam\dwh\source\stores\cls_stores.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\stores\ce_stores.sql
@D:\epam\dwh\source\stores\grant_ce_stores_to_bl_cl.sql
@D:\epam\dwh\source\stores\seq_stores.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\stores\pkg_load_3nf_stores_def.sql
@D:\epam\dwh\source\stores\pkg_load_3nf_stores_impl.sql
@D:\epam\dwh\source\stores\load_stores.sql