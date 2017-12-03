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

-- ! Execute full_deliveries start with sys or system
CONNECT sa_src / sa_src;

SHOW USER;

@ext_deliveries.sql

@ext_deliveries-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_deliveries.sql

@cls_deliveries.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_deliveries.sql

@ce_deliveries-grants.sql

@ce_deliveries-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_deliveries_def.sql

@pkg_load_3nf_deliveries_impl.sql

@load_deliveries.sql

/*select * from sa_src.ext_deliveries;
select * from bl_cl.wrk_deliveries;
select * from bl_cl.cls_deliveries;
select * from bl_3nf.ce_deliveries; */