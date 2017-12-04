EXEC pkg_etl_load_cl_tables.load_cl_vehicle_type;
EXEC pkg_etl_load_cl_tables.load_cl_repaired_status;
EXEC pkg_etl_load_cl_tables.load_cl_gearbox_type;
EXEC pkg_etl_load_cl_tables.load_cl_engine_type;
EXEC pkg_etl_load_cl_tables.load_cl_brand;

SELECT count(*) FROM cl_vehicle_type;
select count(*) FROM cl_repaired_status;
select count(*) FROM cl_gearbox_type;
SELECT count(*) FROM cl_engine_type;
SELECT count(*) FROM cl_brand;

commit;
