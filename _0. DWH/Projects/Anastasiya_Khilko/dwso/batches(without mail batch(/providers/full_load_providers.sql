connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\providers\ext_providers.sql
@D:\epam\dwh\source\providers\grant_ext_prov_to_bl_cl.sql


connect BL_CL/123456;
show user;
@D:\epam\dwh\source\providers\wrk_providers.sql
@D:\epam\dwh\source\providers\cls_providers.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\providers\ce_providers.sql
@D:\epam\dwh\source\providers\grant_ce_providers_to_bl_cl.sql
@D:\epam\dwh\source\providers\seq_providers.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\providers\pkg_load_3nf_providers_def.sql
@D:\epam\dwh\source\providers\pkg_load_3nf_providers_impl.sql
@D:\epam\dwh\source\providers\load_providers.sql