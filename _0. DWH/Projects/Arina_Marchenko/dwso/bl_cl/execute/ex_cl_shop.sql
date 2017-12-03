EXEC pkg_etl_load_cl_shop.load_cl_shop;
SELECT count(*) FROM cl_shop;
commit;