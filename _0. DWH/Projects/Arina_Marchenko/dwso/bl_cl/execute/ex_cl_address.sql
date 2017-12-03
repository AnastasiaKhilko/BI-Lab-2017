EXEC pkg_etl_load_cl_address.load_cl_address;
SELECT count(*) FROM cl_address;
commit;