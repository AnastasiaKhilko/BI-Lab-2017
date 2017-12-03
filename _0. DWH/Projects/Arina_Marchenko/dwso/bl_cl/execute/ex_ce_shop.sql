EXEC pkg_etl_load_ce_tables.load_ce_shop;
SELECT count(*) FROM bl_3nf.ce_shop;
commit;