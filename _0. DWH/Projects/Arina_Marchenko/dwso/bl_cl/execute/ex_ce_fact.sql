EXEC pkg_etl_load_ce_orders.load_ce_orders;
SELECT count(*) FROM bl_3nf.ce_orders;
commit;