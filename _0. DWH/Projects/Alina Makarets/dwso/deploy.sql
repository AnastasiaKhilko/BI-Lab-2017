@D:\dwh\system\tablespace.sql
@D:\dwh\system\sa_src\sa_src_user.sql
@D:\dwh\system\sa_src\sa_src_grants.sql
@D:\dwh\system\bl_cl\bl_cl_user.sql
@D:\dwh\system\bl_cl\bl_cl_grants.sql
@D:\dwh\system\bl_3nf\bl_3nf_user.sql
@D:\dwh\system\bl_3nf\bl_3nf_grants.sql
@D:\dwh\system\bl_cl_dm\bl_cl_dm_user.sql
@D:\dwh\system\bl_cl_dm\bl_cl_dm_grants.sql
@D:\dwh\system\bl_dm\bl_dm_user.sql
@D:\dwh\system\bl_dm\bl_dm_grants.sql



connect sa_src/123;
show user;
@D:\dwh\sa_src\create_directory.sql

@D:\dwh\sa_src\tables\ext_customers.sql
@D:\dwh\sa_src\tables\ext_employees.sql
@D:\dwh\sa_src\tables\ext_products.sql
@D:\dwh\sa_src\tables\ext_shops.sql

@D:\dwh\sa_src\create_public_synonyms.sql
@D:\dwh\sa_src\grants_to_bl_cl.sql

connect bl_cl/123;
show user;
@D:\dwh\bl_cl\tables\wrk\wrk_customers\wrk_customers.sql
@D:\dwh\bl_cl\tables\wrk\wrk_employees\wrk_employees.sql
@D:\dwh\bl_cl\tables\wrk\wrk_products\wrk_products.sql
@D:\dwh\bl_cl\tables\wrk\wrk_shops\wrk_shops.sql

@D:\dwh\bl_cl\tables\cls\cls_categories\cls_categories.sql
@D:\dwh\bl_cl\tables\cls\cls_cities\cls_cities.sql
@D:\dwh\bl_cl\tables\cls\cls_collections\cls_collections.sql
@D:\dwh\bl_cl\tables\cls\cls_colors\cls_colors.sql
@D:\dwh\bl_cl\tables\cls\cls_customers\cls_customers.sql
@D:\dwh\bl_cl\tables\cls\cls_date\cls_date.sql
@D:\dwh\bl_cl\tables\cls\cls_employees\cls_employees.sql
@D:\dwh\bl_cl\tables\cls\cls_fct_table\cls_sales.sql
@D:\dwh\bl_cl\tables\cls\cls_products\cls_products.sql
@D:\dwh\bl_cl\tables\cls\cls_regions\cls_regions.sql
@D:\dwh\bl_cl\tables\cls\cls_shops\cls_shops.sql
@D:\dwh\bl_cl\tables\cls\cls_subcategories\cls_subcategories.sql

connect bl_3nf/123;
show user;
@D:\dwh\bl_3nf\tables\ce_colors\ce_colors.sql
@D:\dwh\bl_3nf\tables\ce_colors\ce_colors_seq.sql
@D:\dwh\bl_3nf\tables\ce_collections\ce_collections.sql
@D:\dwh\bl_3nf\tables\ce_collections\ce_collections_seq.sql
@D:\dwh\bl_3nf\tables\ce_categories\ce_categories.sql
@D:\dwh\bl_3nf\tables\ce_categories\ce_categories_seq.sql
@D:\dwh\bl_3nf\tables\ce_subcategories\ce_subcategories.sql
@D:\dwh\bl_3nf\tables\ce_subcategories\ce_subcategories_seq.sql
@D:\dwh\bl_3nf\tables\ce_products\ce_products.sql
@D:\dwh\bl_3nf\tables\ce_products\ce_products_seq.sql
@D:\dwh\bl_3nf\tables\ce_regions\ce_regions.sql
@D:\dwh\bl_3nf\tables\ce_regions\ce_regions_seq.sql
@D:\dwh\bl_3nf\tables\ce_cities\ce_cities.sql
@D:\dwh\bl_3nf\tables\ce_cities\ce_cities_seq.sql
@D:\dwh\bl_3nf\tables\ce_customers\ce_customers.sql
@D:\dwh\bl_3nf\tables\ce_customers\ce_customers_seq.sql
@D:\dwh\bl_3nf\tables\ce_employees\ce_employees.sql
@D:\dwh\bl_3nf\tables\ce_employees\ce_employees_seq.sql
@D:\dwh\bl_3nf\tables\ce_shops\ce_shops.sql
@D:\dwh\bl_3nf\tables\ce_shops\ce_shops_seq.sql
@D:\dwh\bl_3nf\tables\ce_date\ce_date.sql
@D:\dwh\bl_3nf\tables\ce_fct_table\ce_sales.sql
@D:\dwh\bl_3nf\tables\ce_fct_table\ce_sales_seq.sql
@D:\dwh\bl_3nf\create_public_synonyms.sql
@D:\dwh\bl_3nf\grants_to_bl_cl.sql

connect bl_cl_dm/123;
show user;
@D:\dwh\bl_cl_dm\tables\cls_dim_customers\cls_dim_customers.sql
@D:\dwh\bl_cl_dm\tables\cls_dim_employees\cls_dim_employees.sql
@D:\dwh\bl_cl_dm\tables\cls_dim_products\cls_dim_products.sql
@D:\dwh\bl_cl_dm\tables\cls_dim_shops\cls_dim_shops.sql
@D:\dwh\bl_cl_dm\tables\cls_dim_time_day\cls_dim_time_day.sql
@D:\dwh\bl_cl_dm\tables\cls_fct_sales\cls_fct_sales.sql


connect bl_dm/123;
show user;
@D:\dwh\bl_dm\tables\dim_customers\dim_customers.sql
@D:\dwh\bl_dm\tables\dim_customers\dim_customers_seq.sql
@D:\dwh\bl_dm\tables\dim_employeees\dim_employees.sql
@D:\dwh\bl_dm\tables\dim_employeees\dim_employees_seq.sql
@D:\dwh\bl_dm\tables\dim_products\dim_products.sql
@D:\dwh\bl_dm\tables\dim_products\dim_products_seq.sql
@D:\dwh\bl_dm\tables\dim_shops\dim_shops.sql
@D:\dwh\bl_dm\tables\dim_shops\dim_shops_seq.sql
@D:\dwh\bl_dm\tables\dim_time_day\dim_time_day.sql
@D:\dwh\bl_dm\tables\fct_table\fct_sales.sql


connect bl_cl/123;
show user;
@D:\dwh\bl_cl\packages\pkg_etl_insert_data.sql

@D:\dwh\bl_cl\tables\wrk\wrk_customers\insert.sql
@D:\dwh\bl_cl\tables\wrk\wrk_employees\insert.sql
@D:\dwh\bl_cl\tables\wrk\wrk_products\insert.sql
@D:\dwh\bl_cl\tables\wrk\wrk_shops\insert.sql

@D:\dwh\bl_cl\packages\pkg_etl_insert_geo.sql
@D:\dwh\bl_cl\packages\pkg_etl_insert_customers.sql
@D:\dwh\bl_cl\packages\pkg_etl_insert_employees.sql
@D:\dwh\bl_cl\packages\pkg_etl_insert_shops.sql
@D:\dwh\bl_cl\packages\pkg_etl_insert_products.sql
@D:\dwh\bl_cl\packages\pkg_etl_insert_time_day.sql
@D:\dwh\bl_cl\packages\pkg_etl_sales.sql

@D:\dwh\bl_cl\execute_pkg.sql

connect bl_cl_dm/123;
show user;
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_customers.sql
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_employees.sql
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_products.sql
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_shops.sql
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_time_day.sql
@D:\dwh\bl_cl_dm\packages\pkg_etl_insert_fct_table.sql

@D:\dwh\bl_cl_dm\execute_package.sql


