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

-- ! Execute full_brands start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_brands.sql

@ext_brands-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_brands.sql

@cls_brands.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_brands.sql

@ce_brands-grants.sql

@ce_brands-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_brands_def.sql

@pkg_load_3nf_brands_impl.sql

@load_brands.sql

/*select * from sa_src.ext_brands;
select * from bl_cl.wrk_brands;
select * from bl_cl.cls_brands;
select * from bl_3nf.ce_brands; */