CREATE OR REPLACE PACKAGE pkg_etl_load_ce_tables
AS
   PROCEDURE load_ce_seller;
END pkg_etl_load_ce_tables;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_ce_tables
AS
   PROCEDURE load_ce_seller
  IS
  BEGIN
    EXECUTE IMMEDIATE 'truncate table bl_3nf.ce_seller';
    MERGE INTO bl_3nf.ce_seller cem
USING ( SELECT seller_code, name, surname, phone, email, city_id, trunc(sysdate) update_dt FROM cl_seller ) clm
ON (cem.seller_code = clm.seller_code)
WHEN MATCHED THEN
  UPDATE SET cem.name = clm.name, cem.surname=clm.surname, cem.phone=clm.phone, cem.email = clm.email, 
  cem.city_id = clm.city_id, update_dt = sysdate
   WHERE DECODE(cem.name, clm.name,0,1)+DECODE(cem.surname,clm.surname,0,1)+DECODE(cem.phone,clm.phone,0,1)
   +DECODE(cem.email, clm.email,0,1)+DECODE(cem.city_id,clm.city_id,0,1)>0 
WHEN NOT MATCHED THEN 
INSERT (  cem.seller_id, cem.seller_code, cem.name, cem.surname, cem.phone, cem.email, cem.city_id, cem.update_dt )
VALUES ( bl_3nf.seq_seller.nextval, clm.seller_code, clm.name, clm.surname, clm.phone, clm.email, clm.city_id,  sysdate);
commit;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END load_ce_seller;
-------------------------------------------
END pkg_etl_load_ce_tables;
/