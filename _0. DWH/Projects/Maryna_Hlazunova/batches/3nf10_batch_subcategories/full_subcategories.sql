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

-- ! Execute full_subcategories start with sys or system
CONNECT bl_cl/bl_cl;

SHOW USER;

@cls_subcategories.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_subcategories.sql

@ce_subcategories-grants.sql

@ce_subcategories-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_subcategories_def.sql

@pkg_load_3nf_subcategories_impl.sql

@load_subcategories.sql

/*select * from sa_src.ext_refer_products;
select * from bl_cl.wrk_refer_products;
select * from bl_cl.cls_subcategories;
select * from bl_3nf.ce_subcategories; */