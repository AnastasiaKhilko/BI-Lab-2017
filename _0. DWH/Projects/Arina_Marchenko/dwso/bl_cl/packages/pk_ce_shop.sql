CREATE OR REPLACE PACKAGE pkg_etl_load_ce_tables
AS
  PROCEDURE load_ce_shop;
END pkg_etl_load_ce_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_tables
AS
PROCEDURE load_ce_shop
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_shop';
  MERGE INTO bl_3nf.ce_shop cem USING
  (SELECT shop_code,
    shop_name,
    phone,
    email,
    address_id,
    TRUNC(sysdate) update_dt
  FROM cl_shop
  ) clm ON (cem.shop_code = clm.shop_code)
WHEN MATCHED THEN
  UPDATE
  SET cem.shop_name                                                                                                                                   = clm.shop_name,
    cem.phone                                                                                                                                         =clm.phone,
    cem.email                                                                                                                                         = clm.email,
    cem.address_id                                                                                                                                    = clm.address_id,
    update_dt                                                                                                                                         = sysdate
  WHERE DECODE(cem.shop_name,clm.shop_name,0,1)+DECODE(cem.phone,clm.phone,0,1)+ 
  DECODE(cem.email,clm.email,0,1)+DECODE(cem.address_id,clm.address_id,0,1)>0 
WHEN NOT MATCHED THEN
  INSERT
    (
      cem.shop_id,
      cem.shop_code,
      cem.shop_name,
      cem.phone,
      cem.email,
      cem.address_id,
      cem.update_dt
    )
    VALUES
    (
      bl_3nf.seq_shop.nextval,
      clm.shop_code,
      clm.shop_name,
      clm.phone,
      clm.email,
      clm.address_id,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_ce_shop;
-------------------------------------------
END pkg_etl_load_ce_tables;
/