EXEC pkg_etl_load_ce_tables.load_ce_seller;
SELECT count(*) FROM bl_3nf.ce_seller;
commit;