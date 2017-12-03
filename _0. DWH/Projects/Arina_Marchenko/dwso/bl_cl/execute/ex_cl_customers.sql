EXEC pkg_etl_load_cl_customers.load_cl_customers;
EXEC pkg_etl_load_cl_customers.load_cl_country;
SELECT count(*) FROM cl_customers;
SELECT count(*) FROM cl_country;
commit;