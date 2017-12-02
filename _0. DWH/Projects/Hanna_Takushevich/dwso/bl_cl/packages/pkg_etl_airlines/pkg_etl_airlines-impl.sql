CREATE OR REPLACE PACKAGE BODY pkg_etl_airlines
AS
  /**===============================================*\
  Name...............:   pkg_etl_airlines
  Contents...........:   Load data of airline entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_airlines';
  INSERT INTO wrk_airlines
  SELECT * FROM ext_airlines;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_airlines';
  INSERT INTO cls_airlines
  SELECT airline_name,
    SUBSTR(icao_iata_codes, 1, 3),
    SUBSTR(icao_iata_codes, 7, 2),
    airline_country
  FROM wrk_airlines
  WHERE airline_country             IS NOT NULL
  AND SUBSTR(icao_iata_codes, 1, 3) IS NOT NULL;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_airlines r USING
  (SELECT airline_name,
    icao_codes,
    iata_codes,
    airline_country
  FROM cls_airlines
  MINUS
  SELECT airline_name,
    icao_codes,
    iata_codes,
    airline_country
  FROM ce_airlines
  ) cls ON ( cls.airline_name = r.airline_name )
WHEN MATCHED THEN
  UPDATE
  SET r.icao_codes   = cls.icao_codes,
    r.iata_codes     = cls.iata_codes,
    r.airline_country=cls.airline_country,
    r.update_dt      = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      airline_id,
      airline_name,
      icao_codes,
      iata_codes,
      airline_country,
      insert_dt,
      update_dt
    )
    VALUES
    (
      airline_seq.nextval ,
      cls.airline_name,
      cls.icao_codes,
      cls.iata_codes,
      cls.airline_country,
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_airlines;