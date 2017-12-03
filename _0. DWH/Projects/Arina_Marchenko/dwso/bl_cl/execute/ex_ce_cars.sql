EXEC pkg_etl_load_ce_cars.load_ce_cars;

SELECT count(*) FROM bl_3nf.ce_cars;


commit;