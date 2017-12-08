

connect BL_CL2/123456;
show user;
@bl_cl2/bl_cl2_ddl.sql

connect BL_3NF/123456;
show user;
@bl_3nf/grants_to_bl_cl2.sql

connect BL_DWH/123456;
show user;
@bl_dwh/bl_dwh_ddl.sql
@bl_dwh/truncate_fact_dwh.sql
@bl_dwh/truncate_date.sql
@bl_dwh/grants_to_bl_cl2.sql
commit;
connect BL_CL2/123456;
show user;
@bl_cl2/batch_pkg.sql



