EXEC pkg_etl_load_dim_cars.load_dim_date;
EXEC pkg_etl_load_dim_cars.load_dim_seller;
EXEC pkg_etl_load_dim_cars.load_dim_customer;
EXEC pkg_etl_load_dim_cars.load_dim_shop;
EXEC pkg_etl_load_dim_cars.load_dim_cars;
EXEC pkg_etl_load_dim_cars.load_fct_orders;


SELECT count(*) FROM bl_dm.dim_date;
SELECT count(*) FROM bl_dm.dim_seller;
SELECT count(*) FROM bl_dm.dim_customers;
SELECT count(*) FROM bl_dm.dim_shop;
SELECT count(*) FROM bl_dm.dim_cars;
SELECT count(*) FROM bl_dm.fct_orders;

commit;
