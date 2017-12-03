CREATE OR REPLACE PACKAGE pkg_etl_load_ce_tables
AS
  PROCEDURE load_ce_city;
END pkg_etl_load_ce_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_tables
AS
PROCEDURE load_ce_city
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_city';
  MERGE INTO bl_3nf.ce_city cem USING
  ( SELECT city_name, country_id, TRUNC(sysdate) update_dt FROM cl_city
  ) clm ON (cem.city_name = clm.city_name AND cem.country_id = clm.country_id)
WHEN MATCHED THEN
  UPDATE SET update_dt = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      cem.city_id,
      cem.city_name,
      cem.country_id,
      cem.update_dt
    )
    VALUES
    (
      bl_3nf.seq_city.nextval,
      clm.city_name,
      clm.country_id,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_ce_city;
-------------------------------------------
END pkg_etl_load_ce_tables;
/