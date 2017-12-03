/*logical order*/
-- sa_src - external tables
-- sa_src - grants on external tables

-- bl_cl - wrk_ and cls_ tables 

-- bl_3nf - ce_ tables
-- bl_3nf - grants on ce_ tables
-- bl_3nf - sequence for ce_ tables
-- bl_3nf - grants for bl_cl

-- bl_cl - create pkg
-- bl_cl - full load

-- ! Execute full_products start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_products.sql

@ext_products-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_products.sql

@cls_colors.sql

@cls_products.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

DROP TABLE ce_products;

@ce_colors.sql

@ce_colors-grants.sql

@ce_colors-seq.sql

@ce_products.sql

@ce_products-grants.sql

@ce_products-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_products_def.sql

@pkg_load_3nf_products_impl.sql

@load_products.sql

/*
select * from sa_src.ext_products;
select * from bl_cl.wrk_products;
select * from bl_cl.cls_products;
select * from bl_cl.cls_products;
select * from bl_3nf.ce_products;
select * from bl_3nf.ce_products; */