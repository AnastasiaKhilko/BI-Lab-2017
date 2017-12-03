CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_service_classes
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_service_classes
  Contents...........:   Load data of service class entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */

PROCEDURE load_to_dim
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO dim_service_classes_scd tgt USING
  (SELECT * FROM cls_dim_service_classes
  ) src ON (src.service_class_code = tgt.service_class_code AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN
  UPDATE
  SET tgt.service_class_name = src.service_class_name,
    tgt.seat_letter  = src.seat_letter,
    tgt.menu         = src.menu,
    tgt.max_luggage  = src.max_luggage,
    tgt.service_class_desc   = src.service_class_desc,
    tgt.end_dt       = src.end_dt 
    
    WHEN NOT MATCHED THEN
  INSERT
    (
      service_class_surr_id,
      service_class_id,
      service_class_code,
      service_class_name,
      seat_letter,
      menu,
      max_luggage,
      service_class_desc,
      start_dt,
      end_dt
    )
    VALUES
    (
      dim_service_class_seq.nextval,
      src.service_class_id,
      src.service_class_code,
      src.service_class_name,
      src.seat_letter,
      src.menu,
      src.max_luggage,
      src.service_class_desc,
      src.start_dt,
      src.end_dt
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_dim;
END pkg_etl_dim_service_classes;