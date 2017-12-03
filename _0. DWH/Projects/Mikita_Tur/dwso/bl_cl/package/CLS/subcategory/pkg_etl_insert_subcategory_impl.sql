CREATE OR REPLACE PACKAGE BODY PKG_ETL_INSERT_subcategory
AS
  PROCEDURE INSERT_TABLE_subCategory
  IS
  BEGIN
    EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_product_subcategory');
    INSERT INTO cls_product_subcategory
      (subcategory_name,
      CATEGORY_NAME
      )
   SELECT DISTINCT NVL(subcategory,'-99'),NVL(CATEGORY,'-99') 
   FROM wrk_products;

    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END INSERT_TABLE_SUBcategory;
---
PROCEDURE MERGE_TABLE_SUBCategory
  IS 
  BEGIN 
  MERGE INTO bl_3nf.ce_product_SUBcategory CESUB using
    (SELECT 
      SUBCategory_SRCID,
      SUBCATEGORY_NAME,
      CAT.Category_SRCID
        FROM CLS_PRODUCT_SUBCATEGORY, BL_3NF.CE_PRODUCT_CATEGORY CAT
        WHERE CLS_PRODUCT_SUBCATEGORY.CATEGORY_NAME=CAT.CATEGORY_NAME
    MINUS
     SELECT 
     SUBCategory_SRCID,
      SUBCATEGORY_NAME,
      Category_SRCID
    FROM BL_3NF.CE_PRODUCT_SUBCATEGORY
    ) CLSSUB ON (CLSSUB.SUBCategory_SRCID = CESUB.SUBCategory_SRCID)
  WHEN MATCHED THEN 
    UPDATE SET CESUB.SUBCategory_NAME = CLSSUB.SUBCategory_NAME
  WHEN NOT MATCHED THEN
    INSERT 
      (
       SUBCategory_SRCID,
      subCategory_NAME,
       Category_SRCID
      )
    VALUES
      (
        bl_3nf.SUBCat_SEQ.NEXTVAL,
        CLSSUB.SUBCategory_NAME,
        CLSSUB.Category_SRCID
      );
      
    COMMIT;
  EXCEPTION 
    WHEN OTHERS THEN RAISE ;
  END MERGE_TABLE_SUBCategory;
END PKG_ETL_INSERT_SUBCategory;
/