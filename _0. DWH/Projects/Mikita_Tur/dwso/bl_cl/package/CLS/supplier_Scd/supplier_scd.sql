CREATE OR REPLACE PACKAGE pkg_etl_insert_SUPPLIER
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_SUPPLER;
  PROCEDURE merge_table_SUPPLIER;
						
END pkg_etl_insert_SUPPLIER;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_SUPPLIER
AS
---------------------------------------------------  
PROCEDURE insert_table_products
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls2_SUPPLIER_scd');
insert into CLS2_supplier_SCD(
    
    sup_id      ,
    sup_NAME    ,
    sup_phone   ,
    SUp_email   ,
    address     ,
    city        ,   
    ate         ,
    COUNTRY     ,
    START_DT    ,
    END_DT      ,
    IS_ACTIVE   
    )
 
select src.supplier_srcid as sup_id,
       src.supplier_name,
       src.phone as sup_phone,
       src.email,
       ca.address,
       cc.city,
       cat.ate_name,
       cco.country_name,
       src.start_dt,
       src.end_dt,
       src.is_active
       from bl_3nf.ce_supplier src left join cls_supplier cs
        on src.supplier_srcid=cs.supplier_srcid,
        left join BL_3NF.ce_address ca on cs.address=ca.address,
        left join bl_3nf.ce_city cc on ca.city_srcid=cc.city_srcid,
        left join bl_3nf.ce_ate cat on cc.ate_srcid=cat.ate_srcid,
        left join BL_3NF.CE_COUNTRY cco on cat.country_srcid=cco.country_srcid;
         end;
		 COMMIT;
	   EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_SUPPLIER;
---------------------------------------------------  
PROCEDURE merge_table_SUPPLIER
IS
BEGIN
MERGE INTO bl_dm.dim_supplier_scd tgt USING
	(SELECT sup_id ,
  sup_NAME ,
  sup_phone ,
  SUp_email ,
  address ,
  city ,
  ate ,
  COUNTRY ,
  START_DT ,
  END_DT ,
  IS_ACTIVE
FROM cls_suppler_scd
MINUS
SELECT sup_id,
  sup_NAME ,
  sup_phone ,
  SUp_email ,
  address ,
  city ,
  ate ,
  COUNTRY ,
  START_DT ,
  END_DT ,
  IS_ACTIVE
FROM bl_dm.dim_supplier_scd
) src ON ( tgt.sup_name = src.sup_name AND tgt.sup_email = src.sup_emaail
AND  tgt.sup_phone = src.sup_phone AND tgt.address = src.address AND tgt.city = src.city 
AND tgt.country = src.country AND tgt.ate = src.ate AND tgt.start_dt = src.start_dt)
WHEN matched THEN
  UPDATE
  SET tgt.sup_id = src.sup_id,
    tgt.end_dt        = src.end_dt,
    tgt.is_active     = src.is_active 
    WHEN NOT matched THEN
  INSERT
    (
      sup_surr_id,
      sup_id ,
  sup_NAME ,
  sup_phone ,
  SUp_email ,
  address ,
  city ,
  ate ,
  COUNTRY ,
  START_DT ,
  END_DT ,
  IS_ACTIVE
    )
    VALUES
    (
      bl_dm.dim_sup_seq.NEXTVAL,
      src.sup_id,
      src.sup_NAME ,
  src.up_phone ,
  src.SUp_email ,
  src.address ,
  src.city ,
  src.ate ,
  src.COUNTRY ,
  src.START_DT ,
  src.END_DT ,
  src.IS_ACTIVE
    ) ;
	   COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END merge_table_SUPPLIER;
--------------------------------------------------- 
END pkg_etl_insert_SUPPLIER;