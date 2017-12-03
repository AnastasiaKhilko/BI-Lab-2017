EXEC pkg_etl_load_ce_tables.load_ce_vehicle_type;
EXEC pkg_etl_load_ce_tables.load_ce_repaired_status;
EXEC pkg_etl_load_ce_tables.load_ce_gearbox_type;
EXEC pkg_etl_load_ce_tables.load_ce_engine_type;
EXEC pkg_etl_load_ce_tables.load_ce_model;

SELECT count(*) FROM bl_3nf.ce_vehicle_type;
select count(*) FROM bl_3nf.ce_repaired_status;
select count(*) FROM bl_3nf.ce_gearbox_type;
SELECT count(*) FROM bl_3nf.ce_engine_type;
SELECT count(*) FROM bl_3nf.ce_model;
commit;