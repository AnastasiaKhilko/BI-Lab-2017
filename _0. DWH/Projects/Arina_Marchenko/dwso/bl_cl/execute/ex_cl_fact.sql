EXEC pkg_etl_load_cl_fact.load_cl_fact;
SELECT count(*) FROM cl_fact;
commit;