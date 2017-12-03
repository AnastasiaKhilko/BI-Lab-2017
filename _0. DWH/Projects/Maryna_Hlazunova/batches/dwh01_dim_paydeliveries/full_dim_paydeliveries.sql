/*logical order*/
-- bl_cl_dwh - cls_ tables 

-- bl_dwh - dim_/fct_ tables
-- bl_3nf - grants on dim_ tables
-- bl_3nf - sequence for dim_ tables
-- bl_3nf - grants for bl_cl_dwh

-- bl_cl_dwh - create pkg
-- bl_cl_dwh - full load

-- ! Execute full_paydeliveries start with sys or system
CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@cls2_paydeliveries.sql

CONNECT bl_dwh/bl_dwh;

SHOW USER;

@dim_paydeliveries.sql

@dim_paydeliveries-grants.sql

@dim_paydeliveries-seq.sql

CONNECT bl_cl_dwh/bl_cl_dwh;

SHOW USER;

@pkg_load_dim_paydeliveries_def.sql

@pkg_load_dim_paydeliveries_impl.sql

@load_dim_paydeliveries.sql

/*
select * from bl_cl_dwh.cls2_paydeliveries;
select * from bl_dwh.dim_paydeliveries;*/