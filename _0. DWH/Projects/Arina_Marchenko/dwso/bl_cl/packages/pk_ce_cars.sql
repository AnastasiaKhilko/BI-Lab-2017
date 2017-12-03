CREATE OR REPLACE PACKAGE pkg_etl_load_ce_cars
AS
  
  PROCEDURE load_ce_cars;
END pkg_etl_load_ce_cars;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_cars
AS
PROCEDURE load_ce_cars
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_cars';
        MERGE INTO bl_3nf.ce_cars cc
USING ( SELECT car_number, car_name, vehicle_type_id, engine_type_id,
gearbox_type_id, model_id, repaired_status_id, start_dt, end_dt FROM cl_cars ) clc
ON (cc.car_number = clc.car_number and cc.start_dt = clc.start_dt and
cc.end_dt = clc.end_dt )
WHEN MATCHED THEN
  UPDATE SET cc.car_name=clc.car_name , 
cc.vehicle_type_id=clc.vehicle_type_id,cc.engine_type_id = clc.engine_type_id  ,
cc.gearbox_type_id= clc.gearbox_type_id ,cc.model_id= clc.model_id ,
cc.repaired_status_id=clc.repaired_status_id
   WHERE DECODE(cc.car_name,clc.car_name,0,1)
   +DECODE(cc.vehicle_type_id,clc.vehicle_type_id,0,1)
   +DECODE(cc.engine_type_id, clc.engine_type_id,0,1)+DECODE(cc.gearbox_type_id,clc.gearbox_type_id,0,1)
   +DECODE(cc.model_id,clc.model_id,0,1)+DECODE(cc.repaired_status_id,clc.repaired_status_id,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT (cc.car_id, cc.car_number, cc.car_name, cc.vehicle_type_id, cc.engine_type_id,
cc.gearbox_type_id, cc.model_id, cc.repaired_status_id, cc.start_dt, cc.end_dt)
values (bl_3nf.seq_cars.nextval, clc.car_number, clc.car_name, clc.vehicle_type_id, clc.engine_type_id,
clc.gearbox_type_id, clc.model_id, clc.repaired_status_id, clc.start_dt, clc.end_dt)  ;
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_cars;
  
END pkg_etl_load_ce_cars;
/
