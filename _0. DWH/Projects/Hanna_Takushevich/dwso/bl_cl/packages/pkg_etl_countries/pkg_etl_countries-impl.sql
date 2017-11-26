CREATE OR REPLACE PACKAGE BODY pkg_etl_countries
AS
  /**===============================================*\
  Name...............:   pkg_etl_countries
  Contents...........:   Load data of country entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_countries';
  INSERT INTO wrk_countries
  SELECT * FROM ext_geo_countries;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_countries';
  INSERT INTO cls_countries
  SELECT
    CASE
      WHEN trim(BOTH ' '
      FROM cc_fips)='-'
      THEN NULL
      ELSE trim(BOTH ' '
      FROM cc_fips)
    END,
    CASE
      WHEN trim(BOTH ' '
      FROM cc_iso) = '-'
      THEN NULL
      ELSE trim(BOTH ' '
      FROM cc_iso)
    END,
    CASE
      WHEN trim(BOTH ' '
      FROM tld) = '-'
      THEN NULL
      ELSE trim(BOTH ' '
      FROM tld)
    END,
    country_name,
    subregion_country_key
  FROM wrk_countries;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;

PROCEDURE load_to_3nf
IS
BEGIN
   MERGE INTO ce_countries co USING
  ( SELECT country_name, cc_fips, tld, cc_iso FROM cls_countries
  MINUS
  SELECT country_name, cc_fips, tld, cc_iso FROM ce_countries
  ) cls ON ( cls.cc_fips = co.cc_fips )
WHEN MATCHED THEN
  UPDATE SET co.country_name = cls.country_name, co.tld = cls.tld WHEN NOT MATCHED THEN
  INSERT
    (
      country_id,
      subregion_id,
      cc_fips,
      cc_iso,
      tld,
      country_name
    )
    VALUES
    (
      country_seq.nextval,
      to_number((select subregion_id from ce_subregions 
	  	join cls_subregions on ce_subregions.subregion_code=cls_subregions.subregion_code 
		join cls_countries on cls_countries.subregion_country_key = cls_subregions.subregion_country_key 
		where cls_countries.country_name = cls.country_name)),
      cls.cc_fips,
      cls.cc_iso,
      cls.tld,
      cls.country_name
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;

END pkg_etl_countries;