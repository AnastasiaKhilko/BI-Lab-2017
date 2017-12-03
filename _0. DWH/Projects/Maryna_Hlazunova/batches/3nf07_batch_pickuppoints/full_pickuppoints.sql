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

-- ! Execute full_pickuppoints start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_pickuppoints.sql

@ext_pickuppoints-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_pickuppoints.sql

@cls_pickuppoints.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_pickuppoints.sql

@ce_pickuppoints-grants.sql

@ce_pickuppoints-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_pickuppoints_def.sql

@pkg_load_3nf_pickuppoints_impl.sql

@load_pickuppoints.sql

/*select * from sa_src.ext_pickuppoints;
select * from bl_cl.wrk_pickuppoints;
select * from bl_cl.cls_pickuppoints;
select * from bl_3nf.ce_pickuppoints; */