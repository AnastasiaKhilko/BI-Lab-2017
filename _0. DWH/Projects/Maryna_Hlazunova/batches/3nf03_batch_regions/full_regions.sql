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

-- ! Execute full_regions start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_locations.sql

@ext_locations-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_locations.sql

@cls_regions.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_regions.sql

@ce_regions-grants.sql

@ce_regions-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_regions_def.sql

@pkg_load_3nf_regions_impl.sql

@load_regions.sql

/*select * from sa_src.ext_locations;
select * from bl_cl.wrk_locations;
select * from bl_cl.cls_regions;
select * from bl_3nf.ce_regions; */