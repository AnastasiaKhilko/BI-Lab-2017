/*logical order*/
-- bl_cl_dwh - cls_ tables 

-- bl_dwh - dim_/fct_ tables
-- bl_dwh - grants on dim_ tables
-- bl_dwh - sequence for dim_ tables
-- bl_dwh - grants for bl_cl_dwh

-- bl_cl_dwh - create pkg
-- bl_cl_dwh - full load

-- ! Execute full_customers_scd start with sys or system
CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@cls2_customers.sql

CONNECT bl_dwh/bl_dwh;

SHOW USER;

@dim_customers_scd.sql

@dim_customers_scd-grants.sql

@dim_customers_scd-seq.sql

CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@pkg_load_dim_customers_def.sql

@pkg_load_dim_customers_impl.sql

@load_dim_customers_scd.sql

/*
select * from bl_cl_dwh.cls2_customers;
select * from bl_dwh.dim_customers_scd;*/