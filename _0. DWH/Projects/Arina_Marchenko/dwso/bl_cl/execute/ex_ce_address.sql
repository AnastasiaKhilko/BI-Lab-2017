EXEC pkg_etl_load_ce_tables.load_ce_address;
SELECT count(*) FROM bl_3nf.ce_address;
commit;