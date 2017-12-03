CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_products;
  PROCEDURE merge_table_products;
						
END pkg_etl_insert_products;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
---------------------------------------------------  
PROCEDURE insert_table_products
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls2_product_scd'); 
insert into CLS2_PRODUCT_SCD(PROD_SURR_ID,
    PROD_id ,
    PROD_NAME        ,
    CATEG_NAME       ,
    SUBCAT_NAME     ,
    PROD_PRICE      ,
    prod_package    ,
    START_DT          ,
    END_DT            ,
    IS_ACTIVE        )
select cp.product_id as prod_surr_ID,cp.PRODUCT_srcID as prod_id,
cp.product_name,
ct.category_name,
sc.subcategory_name,
cp.product_price,
cp.product_package,
cp.start_dt,
cp.end_dt,
cp.is_active
from BL_3NF.CE_PRODUCT cp left join( BL_3NF.CE_PRODUCT_SUBCATEGORY
 sc left join BL_3NF.CE_PRODUCT_CATEGORY ct on sc.category_srcid=ct.category_srcid ) on cp.SUBCATEGORY_SRCID=sc.SUBCATEGORY_SRCID;
END;
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
END insert_table_products;
---------------------------------------------------  
PROCEDURE merge_table_products
IS
BEGIN
MERGE INTO bl_dm.dim_product_scd tgt USING
(SELECT prod_surr_id,

  PROD_NAME ,
  CATEG_NAME ,
  SUBCAT_NAME ,
  PROD_PRICE ,
  prod_package ,
  START_DT ,
  END_DT ,
  IS_ACTIVE
FROM CLS2_PRODUCT_SCD
MINUS
SELECT PROD_id ,
  PROD_NAME ,
  CATEG_NAME ,
  SUBCAT_NAME ,
  PROD_PRICE ,
  prod_package ,
  START_DT ,
  END_DT ,
  IS_ACTIVE
FROM bl_dm.dim_product_scd tgt
) src ON (tgt.prod_name=src.PROD_NAME AND tgt.prod_price=src.prod_price AND tgt.prod_package=src.prod_package)
WHEN matched THEN
  UPDATE
  SET tgt.prod_id = src.prod_surr_id,
    tgt.END_DT    =src.end_dt,
    tgt.IS_ACTIVE =src.is_active WHEN NOT matched THEN
  INSERT
    (
      prod_surr_id,
      PROD_id ,
      PROD_NAME ,
      CATEG_NAME ,
      SUBCAT_NAME ,
      PROD_PRICE ,
      prod_package ,
      START_DT ,
      END_DT ,
      IS_ACTIVE
    )
    VALUES
    (
      bl_dm.dim_prod_seq.NEXTVAL,
      src.prod_surr_id,
      src.PROD_NAME ,
      src.CATEG_NAME ,
      src.SUBCAT_NAME ,
      src.PROD_PRICE ,
      src.prod_package ,
      src.START_DT ,
      src.END_DT ,
      src.IS_ACTIVE
    ) ;
  COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END merge_table_products;
--------------------------------------------------- 
END pkg_etl_insert_products;