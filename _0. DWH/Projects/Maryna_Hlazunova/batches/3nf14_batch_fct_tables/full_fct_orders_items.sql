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

-- ! Execute full_fct_tables start with sys or system
CONNECT bl_cl/bl_cl;

SHOW USER;

@wrk_fct_orders.sql

@cls_fct_orders.sql

@cls_fct_items.sql

CONNECT bl_3nf/bl_3nf;

SHOW USER;

DROP TABLE ce_fct_items;

@ce_fct_orders.sql

@ce_fct_orders-grants.sql

@ce_fct_orders-seq.sql

@ce_fct_items.sql

@ce_fct_items-grants.sql

@ce_fct_items-seq.sql

CONNECT bl_cl/bl_cl;

SHOW USER;

@pkg_load_3nf_facts_def.sql

@pkg_load_3nf_facts_impl.sql

@load_fct_tables.sql

/*select * from sa_src.ext_deliveries;
select * from bl_cl.wrk_deliveries;
select * from bl_cl.cls_deliveries;
select * from bl_3nf.ce_deliveries; */