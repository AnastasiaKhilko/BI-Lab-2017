EXEC pkg_etl_load_cl_city.load_cl_city;
SELECT count(*) FROM cl_city;
commit;