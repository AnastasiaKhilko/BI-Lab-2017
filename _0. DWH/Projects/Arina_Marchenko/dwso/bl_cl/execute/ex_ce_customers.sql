EXEC pkg_etl_load_ce_customers.load_ce_customers;
EXEC pkg_etl_load_ce_customers.load_ce_country;
SELECT count(*) FROM bl_3nf.ce_customers;
SELECT count(*) FROM bl_3nf.ce_country;
commit;