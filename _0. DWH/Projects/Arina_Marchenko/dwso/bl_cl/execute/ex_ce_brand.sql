EXEC pkg_etl_load_ce_brand.load_ce_brand;

SELECT count(*) FROM bl_3nf.ce_brand;


commit;