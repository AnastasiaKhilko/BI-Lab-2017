EXEC pkg_etl_load_cl_model.load_cl_model;
SELECT count(*) FROM cl_model;
commit;