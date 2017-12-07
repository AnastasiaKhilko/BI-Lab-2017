CREATE OR REPLACE PACKAGE pkg_etl_insert_products
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_products;  
END pkg_etl_insert_products;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_products
AS
PROCEDURE merge_ce_products
IS
BEGIN

MERGE INTO bl_3nf.ce_products t USING
    ( SELECT product_id,
             product_name,
             product_type_id,
             start_dt,
             end_dt,
             is_active
      FROM   cls_products
    MINUS
      SELECT product_srcid AS product_id,
             product_name,
             product_type_srcid AS product_type_id,            
             start_dt,
             end_dt,
             is_active
      FROM   bl_3nf.ce_products
    ) c ON ( t.product_srcid = c.product_id
        AND  c.product_name = t.product_name 
        AND  t.product_type_srcid = c.product_type_id
        AND  c.start_dt = t.start_dt
)
    WHEN MATCHED THEN
    UPDATE SET 
           t.end_dt = c.end_dt,
           t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        product_id,
        product_srcid,
        product_name,
        product_type_srcid,
        start_dt,
        end_dt,
        is_active
      )
      VALUES
      (
        bl_3nf.ce_products_seq.NEXTVAL,
        c.product_id,
        c.product_name,
        c.product_type_id,
        c.start_dt,
        c.end_dt,
        c.is_active
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_products;
END pkg_etl_insert_products;
/