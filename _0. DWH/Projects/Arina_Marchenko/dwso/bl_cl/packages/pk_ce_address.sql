CREATE OR REPLACE PACKAGE pkg_etl_load_ce_tables
AS
  PROCEDURE load_ce_address;
END pkg_etl_load_ce_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_tables
AS
PROCEDURE load_ce_address
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_address';
  MERGE INTO bl_3nf.ce_address cem USING
  ( SELECT address_name, city_id, TRUNC(sysdate) update_dt FROM cl_address
  ) clm ON (cem.address_name = clm.address_name)
WHEN MATCHED THEN
  UPDATE
  SET cem.city_id                          = clm.city_id,
    update_dt                              = sysdate
  WHERE DECODE(cem.city_id,clm.city_id,0,1)>0 WHEN NOT MATCHED THEN
  INSERT
    (
      cem.address_id,
      cem.address_name,
      cem.city_id,
      cem.update_dt
    )
    VALUES
    (
      bl_3nf.seq_address.nextval,
      clm.address_name,
      clm.city_id,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_ce_address;
-------------------------------------------
END pkg_etl_load_ce_tables;
/