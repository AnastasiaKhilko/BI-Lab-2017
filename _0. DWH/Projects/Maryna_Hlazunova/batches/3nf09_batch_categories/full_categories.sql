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

-- ! Execute full_categories start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_refer_products.sql

@ext_refer_products-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_refer_products.sql

@cls_categories.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_categories.sql

@ce_categories-grants.sql

@ce_categories-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_categories_def.sql

@pkg_load_3nf_categories_impl.sql

@load_categories.sql

/*select * from sa_src.ext_refer_products;
select * from bl_cl.wrk_ext_refer_products;
select * from bl_cl.cls_categories;
select * from bl_3nf.ce_categories; */