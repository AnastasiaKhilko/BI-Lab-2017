/*logical order*/

-- bl_dwh - dim_/fct_ tables
-- bl_dwh - grants on dim_ tables
-- bl_dwh - generate dates

-- ! Execute full_products_scd start with sys or system
CONNECT bl_dwh/bl_dwh;

SHOW USER;

@dim_dates.sql

@dim_dates-grants.sql

@dim_dates_gen_data.sql

/*
select * from bl_cl_dwh.cls2_products;
select * from bl_dwh.dim_products_scd;*/