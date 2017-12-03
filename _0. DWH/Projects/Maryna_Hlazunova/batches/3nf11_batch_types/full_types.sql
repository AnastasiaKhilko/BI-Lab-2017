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

-- ! Execute full_types start with sys or system
CONNECT bl_cl / bl_cl;

SHOW USER;

@cls_types.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_types.sql

@ce_types-grants.sql

@ce_types-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_types_def.sql

@pkg_load_3nf_types_impl.sql

@load_types.sql

/*select * from sa_src.ext_refer_products;
select * from bl_cl.wrk_refer_products;
select * from bl_cl.cls_types;
select * from bl_3nf.ce_types; */