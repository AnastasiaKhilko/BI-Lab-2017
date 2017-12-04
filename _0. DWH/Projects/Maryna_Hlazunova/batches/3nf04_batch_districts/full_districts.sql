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

-- ! Execute full_districts start with sys or system
CONNECT bl_cl/bl_cl;

SHOW USER;

@cls_districts.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_districts.sql

@ce_districts-grants.sql

@ce_districts-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_districts_def.sql

@pkg_load_3nf_districts_impl.sql

@load_districts.sql

/*select * from sa_src.ext_locations;
select * from bl_cl.wrk_locations;
select * from bl_cl.cls_districts;
select * from bl_3nf.ce_districts; */