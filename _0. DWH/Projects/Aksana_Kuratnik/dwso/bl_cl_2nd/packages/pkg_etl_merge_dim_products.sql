CREATE OR REPLACE PACKAGE pkg_etl_merge_products
AUTHID CURRENT_USER
AS
  PROCEDURE merge_dim_products;
						
END pkg_etl_merge_products;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_merge_products
AS
PROCEDURE merge_dim_products
IS
BEGIN
MERGE INTO bl_dm.dim_products t USING
    ( SELECT product_surr_id,
             product_name,
             category_name,
             product_type,
             price,
             start_dt,
             end_dt,
             is_active 
      FROM   cls_products
    MINUS
      SELECT product_id,
             product_name,
             category_name,
             product_type,          
             price,
             start_dt,
             end_dt,
             is_active           
      FROM   bl_dm.dim_products
    ) c ON ( t.product_name = c.product_name
       AND   t.category_name = c.category_name
       AND   t.product_type = c.product_type
       AND   t.price = c.price
       AND   t.start_dt = c.start_dt)
    WHEN matched THEN
    UPDATE SET t.product_id = c.product_surr_id,
               t.end_dt = c.end_dt,
               t.is_active = c.is_active
    WHEN NOT matched THEN
    INSERT
      (
        product_surr_id,
        product_id,
        product_name,
        category_name,
        product_type,  
        price,
        start_dt,
        end_dt,
        is_active 
      )
      VALUES
      (
        bl_dm.dim_products_seq.NEXTVAL,
        c.product_surr_id,
        c.product_name,
        c.category_name,
        c.product_type,
        c.price,
        c.start_dt,
        c.end_dt,
        c.is_active 
      ) ;
    COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END merge_dim_products;
END pkg_etl_merge_products;
/