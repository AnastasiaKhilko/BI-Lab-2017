EXEC pkg_etl_load_cl_tables.load_cl_dim_cars;
EXEC pkg_etl_load_cl_tables.load_cl_dim_customers;
EXEC pkg_etl_load_cl_tables.load_cl_dim_date;
EXEC pkg_etl_load_cl_tables.load_cl_dim_seller;
EXEC pkg_etl_load_cl_tables.load_cl_dim_shop;
EXEC pkg_etl_load_cl_tables.load_cl_fct_table;

SELECT count(*) FROM cl_dim_cars;
SELECT count(*) FROM cl_dim_customers;
SELECT count(*) FROM cl_dim_date;
SELECT count(*) FROM cl_dim_seller;
SELECT count(*) FROM cl_dim_shop;
SELECT count(*) FROM cl_fct_orders;
commit;
