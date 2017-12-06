connect BL_CL_DM/blcldm;
show user;
@D:\epam\dwh\source\dim_customers\cls_customers.sql

connect BL_DM/bldm;
show user;
@D:\epam\dwh\source\dim_customers\dim_customers_scd.sql
@D:\epam\dwh\source\dim_customers\grant_dim_customers_scd.sql
@D:\epam\dwh\source\dim_customers\seq_dim_customers_scd.sql

connect BL_CL_DM/blcldm;
show user;
@D:\epam\dwh\source\dim_customers\pkg_load_dim_customers_def.sql
@D:\epam\dwh\source\dim_customers\pkg_load_3nf_dim_customers_impl.sql
@D:\epam\dwh\source\dim_customers\load_dim_customers.sql
