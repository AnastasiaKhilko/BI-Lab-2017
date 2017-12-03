/*logical order*/
-- bl_cl_dwh - cls_ tables 

-- bl_dwh - dim_/fct_ tables
-- bl_dwh - grants on dim_ tables
-- bl_dwh - sequence for dim_ tables
-- bl_dwh - grants for bl_cl_dwh

-- bl_cl_dwh - create pkg
-- bl_cl_dwh - full load

-- ! Execute full_products_scd start with sys or system
CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@cls2_fct_salesitems.sql

CONNECT bl_dwh/bl_dwh;

SHOW USER;

@fct_salesitems.sql

@fct_salesitems-grants.sql

CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@pkg_load_fct_salesitems_def.sql

@pkg_load_fct_salesitems_impl.sql

@load_fct_salesitems.sql

/*
select * from bl_cl_dwh.cls2_fct_salesitems;
select * from bl_dwh.fct_salesitems;*/