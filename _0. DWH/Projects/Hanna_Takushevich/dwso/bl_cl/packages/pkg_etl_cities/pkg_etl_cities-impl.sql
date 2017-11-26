CREATE OR REPLACE PACKAGE BODY pkg_etl_cities
AS
  /**===============================================*\
  Name...............:   pkg_etl_cities
  Contents...........:   Load data of city entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_cities';
  INSERT INTO wrk_cities
  SELECT * FROM ext_geo_cities;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_cities';
  INSERT INTO cls_cities
  SELECT * from wrk_cities;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;

PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_cities ct USING
  ( SELECT city_name, cc_fips FROM cls_cities
  MINUS
  SELECT city_name, cc_fips FROM ce_cities
  ) cls ON ( cls.city_name = ct.city_name )
WHEN MATCHED THEN
  UPDATE SET ct.cc_fips = cls.cc_fips WHEN NOT MATCHED THEN
  INSERT
    (
      city_id,
      country_id,
      cc_fips,
      city_name
    )
    VALUES
    (
      city_seq.nextval ,
      (select country_id from ce_countries where ce_countries.cc_fips=cls.cc_fips),
      cls.cc_fips,
      cls.city_name
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;

END pkg_etl_cities;