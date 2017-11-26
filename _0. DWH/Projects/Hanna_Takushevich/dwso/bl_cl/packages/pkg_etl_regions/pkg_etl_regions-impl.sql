CREATE OR REPLACE PACKAGE BODY pkg_etl_regions
AS
  /**===============================================*\
  Name...............:   pkg_etl_regions
  Contents...........:   Load data of region entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_regions';
  INSERT INTO wrk_regions
  SELECT * FROM ext_geo_regions;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_regions';
  INSERT INTO cls_regions
  SELECT *
  FROM wrk_regions;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_regions r USING
  ( SELECT region_code, region_name FROM cls_regions
  MINUS
  SELECT region_code, region_name FROM ce_regions
  ) cls ON ( cls.region_code = r.region_code )
WHEN MATCHED THEN
  UPDATE SET r.region_name = cls.region_name WHEN NOT MATCHED THEN
  INSERT
    (
      region_id,
      region_code,
      region_name
    )
    VALUES
    (
      region_seq.nextval ,
      cls.region_code,
      cls.region_name
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_regions;