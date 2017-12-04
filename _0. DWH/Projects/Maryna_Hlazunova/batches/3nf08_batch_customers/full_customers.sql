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

-- ! Execute full_customers start with sys or system
CONNECT sa_src/sa_src;

SHOW USER;

@ext_customers.sql

@ext_customers-grants.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_customers.sql

@wrk_customers2.sql

@cls_customers.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

@ce_customers.sql

@ce_customers-grants.sql

@ce_customers-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_customers_def.sql

@pkg_load_3nf_customers_impl.sql

@load_customers.sql

/*select * from sa_src.ext_customers;
select * from bl_cl.wrk_customers;
select * from bl_cl.wrk_customers2;
select * from bl_cl.cls_customers;
select * from bl_3nf.ce_customers; */