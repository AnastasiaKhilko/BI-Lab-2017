EXEC pkg_etl_load_ce_tables.load_ce_city;
SELECT count(*) FROM bl_3nf.ce_city;
commit;