CREATE OR REPLACE PACKAGE BODY PKG_ETL_INSERT_category
AS
  PROCEDURE INSERT_TABLE_Category
  IS
  BEGIN
    EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_product_category');
    INSERT INTO cls_product_category
      (category_name
      )
    SELECT DISTINCT NVL(category,'-99') FROM wrk_products;

    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE;
  END INSERT_TABLE_category;
---
PROCEDURE MERGE_TABLE_Category
  IS 
  BEGIN 
  MERGE INTO bl_3nf.ce_product_category CECat using
    (SELECT 
      Category_SRCID,
      Category_NAME
        FROM CLS_PRODUCT_CATEGORY
    MINUS
     SELECT 
     Category_SRCID,
      Category_NAME
    FROM BL_3NF.CE_PRODUCT_CATEGORY
    ) CLSCat ON (CLSCat.Category_SRCID = CECat.Category_SRCID)
  WHEN MATCHED THEN 
    UPDATE SET CECat.Category_NAME = CLSCat.Category_NAME
  WHEN NOT MATCHED THEN
    INSERT 
      (
       Category_SRCID,
      Category_NAME
      )
    VALUES
      (
        bl_3nf.Cat_SEQ.NEXTVAL,
        CLSCat.Category_NAME
      );
      
    COMMIT;
  EXCEPTION 
    WHEN OTHERS THEN RAISE ;
  END MERGE_TABLE_Category;
END PKG_ETL_INSERT_Category;
/