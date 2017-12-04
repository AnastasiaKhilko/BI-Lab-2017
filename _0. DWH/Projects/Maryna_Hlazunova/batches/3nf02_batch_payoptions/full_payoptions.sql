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

-- ! Execute full_payoptions start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_payoptions.sql

@ext_payoptions-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_payoptions.sql

@cls_payoptions.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_payoptions.sql

@ce_payoptions-grants.sql

@ce_payoptions-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_payoptions_def.sql

@pkg_load_3nf_payoptions_impl.sql

@load_payoptions.sql

/*select * from sa_src.ext_payoptions;
select * from bl_cl.wrk_payoptions;
select * from bl_cl.cls_payoptions;
select * from bl_3nf.ce_payoptions; */