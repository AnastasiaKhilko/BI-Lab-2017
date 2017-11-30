CREATE OR REPLACE PACKAGE BODY pkg_etl_service_classes
AS
  /**===============================================*\
  Name...............:   pkg_etl_service_classes
  Contents...........:   Load data of service class entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_service_classes';
  INSERT INTO wrk_service_classes
  SELECT * FROM ext_service_classes;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_service_classes';
  INSERT
  INTO cls_service_classes
    (
      class_name,
      seat_letter,
      menu,
      max_luggage,
      class_desc,
      class_code,
      start_dt,
      end_dt
    )
  SELECT src.class_name,
    src.seat_letter,
    src.menu,
    to_number(src.max_luggage),
    src.class_desc,
    trim(leading chr(39)
  FROM trim(both chr(13)
  FROM src.class_code)),
    NVL2(tgt.class_code, TRUNC(sysdate), TO_DATE('01/01/1900','DD/MM/YYYY')) start_dt,
    TO_DATE('31/12/9999','DD/MM/YYYY') end_dt
  FROM wrk_service_classes src
  LEFT JOIN cls_service_classes tgt
  ON (tgt.start_dt  <= TRUNC(sysdate)
  AND tgt.end_dt     > TRUNC(sysdate)
  AND tgt.class_code = trim(leading chr(39)
  FROM trim(both chr(13)
  FROM src.class_code)))
  WHERE DECODE(src.class_name, tgt.class_name, 0,1)+DECODE(src.seat_letter, tgt.seat_letter, 0,1)+DECODE(src.menu, tgt.menu, 0,1)+DECODE(src.class_desc, tgt.class_desc, 0,1)>0
  UNION ALL
  SELECT tgt.class_name,
    tgt.seat_letter,
    tgt.menu,
    tgt.max_luggage,
    tgt.class_desc,
    tgt.class_code,
    tgt.start_dt,
    TRUNC(sysdate) end_dt
  FROM wrk_service_classes src
  JOIN cls_service_classes tgt
  ON (tgt.start_dt  <= TRUNC(sysdate)
  AND tgt.end_dt     > TRUNC(sysdate)
  AND tgt.class_code = trim(leading chr(39)
  FROM trim(both chr(13)
  FROM src.class_code)))
  WHERE DECODE(src.class_name, tgt.class_name, 0,1)+DECODE(src.seat_letter, tgt.seat_letter, 0,1)+DECODE(src.menu, tgt.menu, 0,1)+DECODE(src.class_desc, tgt.class_desc, 0,1)>0;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_service_classes tgt USING
  (SELECT * FROM cls_service_classes
  ) src ON (src.class_code = tgt.class_code AND src.start_dt = tgt.start_dt)
WHEN MATCHED THEN
  UPDATE
  SET tgt.class_name = src.class_name,
    tgt.seat_letter  = src.seat_letter,
    tgt.menu         = src.menu,
    tgt.max_luggage  = src.max_luggage,
    tgt.class_desc   = src.class_desc,
    tgt.end_dt       = src.end_dt WHEN NOT MATCHED THEN
  INSERT
    (
      class_id,
      class_name,
      seat_letter,
      menu,
      max_luggage,
      class_desc,
      class_code,
      start_dt,
      end_dt
    )
    VALUES
    (
      service_class_seq.nextval,
      src.class_name,
      src.seat_letter,
      src.menu,
      src.max_luggage,
      src.class_desc,
      src.class_code,
      src.start_dt,
      src.end_dt
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_service_classes;