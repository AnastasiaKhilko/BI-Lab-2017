EXEC pkg_etl_load_cl_seller.load_cl_seller;
SELECT count(*) FROM cl_seller;
commit;