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

-- ! Execute full_localities start with sys or system
CONNECT bl_cl/bl_cl;

SHOW USER;

@cls_localities.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_localities.sql

@ce_localities-grants.sql

@ce_localities-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_localities_def.sql

@pkg_load_3nf_localities_impl.sql

@load_localities.sql

/*select * from sa_src.ext_locations;
select * from bl_cl.wrk_locations;
select * from bl_cl.cls_localities;
select * from bl_3nf.ce_localities; */