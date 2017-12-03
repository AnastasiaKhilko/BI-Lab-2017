EXEC pkg_etl_load_cl_cars.load_cl_cars;
SELECT count(*) FROM cl_cars;
commit;