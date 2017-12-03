 CREATE OR REPLACE PACKAGE pkg_etl_load_cl_cars AS
       PROCEDURE load_cl_cars;
END pkg_etl_load_cl_cars;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_load_cl_cars
AS
PROCEDURE load_cl_cars
  IS
  BEGIN
  EXECUTE IMMEDIATE 'truncate table cl_cars';
INSERT
INTO cl_cars
  (
    car_number,
    car_name,
    vehicle_type_id,
    engine_type_id,
    gearbox_type_id,
    model_id,
    repaired_status_id,
    start_dt,
    end_dt
  )
SELECT  DISTINCT 
        c.car_number as car_number,
        c.car_name as car_name, 
        vt.vehicle_type_id as vehicle_type_id, 
        et.engine_type_id as engine_type_id, 
        gt.gearbox_type_id as gearbox_type_id,
        m.model_id as model_id,
        rst.repaired_status_id as repaired_status_id,
        c.reg_date as start_dt,
        TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
FROM  wrk_cars c
left join bl_3nf.ce_vehicle_type vt on c.vehicle_type = vt.vehicle_type_name
left join bl_3nf.ce_engine_type et on c.engine_type = et.engine_type_name
left join bl_3nf.ce_gearbox_type gt on c.gearbox_type = gt.gearbox_type_name
left join bl_3nf.ce_model m on c.model = m.model_name
left join bl_3nf.ce_repaired_status rst on c.repaired_status = rst.repaired_status_name;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_cl_cars;
    END pkg_etl_load_cl_cars;
/
