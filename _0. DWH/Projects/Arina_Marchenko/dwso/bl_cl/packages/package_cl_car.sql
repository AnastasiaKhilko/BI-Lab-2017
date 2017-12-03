-----no cars
CREATE OR REPLACE PACKAGE pkg_etl_load_cl_tables AS
     PROCEDURE load_cl_vehicle_type;
     PROCEDURE load_cl_repaired_status;
     PROCEDURE load_cl_gearbox_type;
     PROCEDURE load_cl_engine_type;
     PROCEDURE load_cl_brand;
END pkg_etl_load_cl_tables;
/


CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_tables
AS
  PROCEDURE load_cl_vehicle_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_vehicle_type';
    INSERT INTO cl_vehicle_type
  (
    vehicle_type_name
  )
    SELECT DISTINCT vehicle_type as vehicle_type_name
	FROM wrk_cars;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_vehicle_type;
  -----------------
   PROCEDURE load_cl_repaired_status
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_repaired_status';
    INSERT INTO cl_repaired_status
  (
    repaired_status_name
  )
    SELECT Distinct repaired_status as repaired_status_name
	FROM wrk_cars;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_repaired_status;
  ------------------------------
  PROCEDURE load_cl_gearbox_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_gearbox_type';
    INSERT INTO cl_gearbox_type
  (
    gearbox_type_name
  )
    SELECT distinct gearbox_type as gearbox_type_name
	FROM wrk_cars;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_gearbox_type; 
  ------------------------------
  PROCEDURE load_cl_engine_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_engine_type';
    INSERT INTO cl_engine_type
  (
    engine_type_name
  )
    SELECT distinct engine_type as engine_type_name
	FROM wrk_cars;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_engine_type; 
  -------------------------------
  PROCEDURE load_cl_brand
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table cl_brand';
   INSERT
INTO cl_brand
  (
    brand_name
  )
SELECT distinct brand as brand_name
FROM wrk_cars;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_brand;

  -------------------------------------------
END pkg_etl_load_cl_tables;
/
