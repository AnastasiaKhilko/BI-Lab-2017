
@system/create_ext_directory.sql
connect sa_src/123456;
show user;
@sa_src/create_ext_tables.sql
@system/grant_to_bl_cl.sql

connect BL_CL/123456;
show user;
@bl_cl/bl_cl_wrk_ddl.sql
@bl_cl/bl_cls_cls_ddl.sql

connect BL_3NF/123456;
show user;
@bl_3nf/bl_3nf_ddl.sql
@grants_to_bl_cl.sql
@bl_3nf/bl_3nf_truncate_orders.sql

connect BL_CL/123456;
show user;
@bl_cl/pkg_load_3nf_banks.sql
@bl_cl/pkg_load_3nf_cards.sql
@bl_cl/load_locations.sql
@bl_cl/pkg_load_3nf_sources.sql
@bl_cl/PKG_LOAD_3NF_categories.sql
@bl_cl/pkg_load_3nf_hotels.sql
@bl_cl/pkg_load_3nf_customers.sql
@bl_cl/pkg_load_3nf_fact.sql
@batch1.sql