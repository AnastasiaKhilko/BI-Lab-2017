CREATE OR REPLACE PACKAGE pkg_etl_load_ce_tables
AS
  PROCEDURE load_ce_vehicle_type;
  PROCEDURE load_ce_repaired_status;
  PROCEDURE load_ce_engine_type;
  PROCEDURE load_ce_gearbox_type;
  PROCEDURE load_ce_model;
END pkg_etl_load_ce_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_tables
AS
PROCEDURE load_ce_vehicle_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_vehicle_type';
    MERGE INTO bl_3nf.ce_vehicle_type cevt
USING ( SELECT vehicle_type_name, trunc(sysdate) update_dt FROM cl_vehicle_type ) clvt
ON (cevt.vehicle_type_name = clvt.vehicle_type_name)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate
   WHEN NOT MATCHED THEN 
INSERT (cevt.vehicle_type_id, cevt.vehicle_type_name, cevt.update_dt )
VALUES (bl_3nf.seq_vehicle_type.nextval, clvt.vehicle_type_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_vehicle_type;
  ------------------------------------------
  PROCEDURE load_ce_repaired_status
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_repaired_status';
    MERGE INTO bl_3nf.ce_repaired_status cers
USING ( SELECT repaired_status_name, trunc(sysdate) update_dt FROM cl_repaired_status ) clrs
ON (cers.repaired_status_name = clrs.repaired_status_name)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate
WHEN NOT MATCHED THEN 
INSERT (cers.repaired_status_id, cers.repaired_status_name, cers.update_dt )
VALUES (bl_3nf.seq_repaired_status.nextval, clrs.repaired_status_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_repaired_status;
  -----------------------------------------
  PROCEDURE load_ce_engine_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_engine_type';
    MERGE INTO bl_3nf.ce_engine_type ceet
USING ( SELECT engine_type_name, trunc(sysdate) update_dt FROM cl_engine_type ) clet
ON (ceet.engine_type_name = clet.engine_type_name)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate
WHEN NOT MATCHED THEN 
INSERT (ceet.engine_type_id, ceet.engine_type_name, ceet.update_dt )
VALUES (bl_3nf.seq_engine_type.nextval, clet.engine_type_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_engine_type;
  -----------------------------------------
   PROCEDURE load_ce_gearbox_type
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_gearbox_type';
    MERGE INTO bl_3nf.ce_gearbox_type cegt
USING ( SELECT gearbox_type_name, trunc(sysdate) update_dt FROM cl_gearbox_type ) clgt
ON (cegt.gearbox_type_name = clgt.gearbox_type_name)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate
WHEN NOT MATCHED THEN 
INSERT (cegt.gearbox_type_id, cegt.gearbox_type_name, cegt.update_dt )
VALUES (bl_3nf.seq_gearbox_type.nextval, clgt.gearbox_type_name, sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_gearbox_type;
  -----------------------------------------
   PROCEDURE load_ce_model
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_model';
    MERGE INTO bl_3nf.ce_model cem
USING ( SELECT model_name, brand_id, trunc(sysdate) update_dt FROM cl_model ) clm
ON (cem.model_name = clm.model_name)
WHEN MATCHED THEN
  UPDATE SET cem.brand_id = clm.brand_id, update_dt = sysdate
   WHERE DECODE(cem.brand_id,clm.brand_id,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT (cem.model_id, cem.model_name, cem.brand_id, cem.update_dt )
VALUES (bl_3nf.seq_model.nextval, clm.model_name, clm.brand_id,  sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_model;
-------------------------------------------
END pkg_etl_load_ce_tables;
/