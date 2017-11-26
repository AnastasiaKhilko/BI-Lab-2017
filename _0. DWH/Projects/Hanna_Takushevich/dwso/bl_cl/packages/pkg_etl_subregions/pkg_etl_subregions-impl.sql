CREATE OR REPLACE PACKAGE BODY pkg_etl_subregions
AS
  /**===============================================*\
  Name...............:   pkg_etl_subregions
  Contents...........:   Load data of subregion entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
  
PROCEDURE load_to_wrk
IS
  subr_code ext_geo_subregions.subregion_id%TYPE;
  subr_name ext_geo_subregions.subregion_name%TYPE;
  subr_country_key ext_geo_subregions.subregion_country_key%TYPE;
  CURSOR c1
  IS
    SELECT * FROM ext_geo_subregions;
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_subregions';
  OPEN c1;
  LOOP
    FETCH c1 INTO subr_code, subr_name, subr_country_key;
    EXIT
  WHEN c1%NOTFOUND;
    INSERT INTO wrk_subregions VALUES
      (subr_code, subr_name, subr_country_key
      );
  END LOOP;
  CLOSE c1;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;

PROCEDURE load_to_cls
IS
  subr_code wrk_subregions.subregion_code%TYPE;
  subr_name wrk_subregions.subregion_name%TYPE;
  subr_country_key wrk_subregions.subregion_country_key%TYPE;
  CURSOR c1
  IS
    SELECT * FROM wrk_subregions;
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_subregions';
  OPEN c1;
  LOOP
    FETCH c1 INTO subr_code, subr_name, subr_country_key;
    EXIT
  WHEN c1%NOTFOUND;
    INSERT INTO cls_subregions VALUES
      (subr_code, subr_name, subr_country_key
      );
  END LOOP;
  CLOSE c1;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;

PROCEDURE load_to_3nf
IS
BEGIN
   MERGE INTO ce_subregions sr USING
  ( SELECT subregion_code, subregion_name FROM cls_subregions
  MINUS
  SELECT subregion_code, subregion_name FROM ce_subregions
  ) cls ON ( cls.subregion_code = sr.subregion_code )
WHEN MATCHED THEN
  UPDATE SET sr.subregion_name = cls.subregion_name WHEN NOT MATCHED THEN
  INSERT
    (
      subregion_id,
      region_id,
      subregion_code,
      subregion_name
    )
    VALUES
    (
      subregion_seq.nextval ,
      (select region_id from ce_regions where to_number(substr(cls.subregion_code, 1,1))=region_code),
      cls.subregion_code,
      cls.subregion_name
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;

END pkg_etl_subregions;