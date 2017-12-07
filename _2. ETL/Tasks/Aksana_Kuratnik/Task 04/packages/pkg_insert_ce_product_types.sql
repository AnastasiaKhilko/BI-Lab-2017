CREATE OR REPLACE PACKAGE pkg_etl_insert_product_types
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_product_types;
END pkg_etl_insert_product_types;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_product_types
AS
PROCEDURE merge_ce_product_types
IS
BEGIN
MERGE INTO bl_3nf.ce_product_types t USING
    ( SELECT product_type_id,
             product_type_name,
             category_id,
             start_dt AS update_dt
      FROM   cls_product_types
    MINUS
      SELECT product_type_srcid AS product_type_id,
             product_type_name  AS product_type_name,
             category_srcid AS category_id,
             update_dt
      FROM   bl_3nf.ce_product_types
    ) c ON ( c.product_type_name = t.product_type_name
         AND t.product_type_srcid = c.product_type_id
         AND t.category_srcid  = c.category_id
           )
    WHEN MATCHED THEN 
      UPDATE SET
       t.update_dt  = SYSDATE 
    WHEN NOT matched THEN
    INSERT
      (
        product_type_id,
        product_type_srcid,
        product_type_name,
        category_srcid,
        update_dt
      )
      VALUES
      (
        bl_3nf.ce_product_types_seq.NEXTVAL,
        c.product_type_id,
        c.product_type_name,
        c.category_id,
        SYSDATE
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_product_types;
END pkg_etl_insert_product_types;
/