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

-- ! Execute full_loc_types start with sys or system
CONNECT bl_cl/bl_cl;

SHOW USER;

@cls_loc_types.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_loc_types.sql

@ce_loc_types-grants.sql

@ce_loc_types-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_loc_types_def.sql

@pkg_load_3nf_loc_types_impl.sql

@load_loc_types.sql

/*select * from sa_src.ext_locations;
select * from bl_cl.wrk_locations;
select * from bl_cl.cls_loc_types;
select * from bl_3nf.ce_loc_types; */