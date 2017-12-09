CREATE OR REPLACE PACKAGE pkg_etl_insert_product_info
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_product_info;  
END pkg_etl_insert_product_info;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_product_info
AS
PROCEDURE merge_ce_product_info
IS
BEGIN

MERGE INTO bl_3nf.ce_product_info t USING
    ( SELECT product_info_id,
             b.product_id as product_srcid,
             price,
             raiting,
             balance,
             insert_dt,
             update_dt
      FROM   cls_product_info a INNER JOIN cls_products b ON a.product_id=b.product_id
    MINUS
      SELECT product_info_srcid AS product_info_id,
             product_srcid,         
             price,
             raiting,
             balance,
             insert_dt,
             update_dt
      FROM   bl_3nf.ce_product_info
    ) c ON ( t.product_srcid = c.product_srcid
       AND   c.raiting = t.raiting
       AND   c.price = t.price
       AND   c.balance = t.balance
    )
    WHEN matched THEN
    UPDATE SET 
           t.update_dt = SYSDATE
    WHEN NOT matched THEN
    INSERT
      (
        product_info_id,
        product_info_srcid,
        product_srcid,
        raiting,
        price,
        balance,
        insert_dt,
        update_dt
      )
      VALUES
      (
        bl_3nf.ce_product_info_seq.NEXTVAL,
        c.product_info_id,
        c.product_srcid,
        c.raiting,
        c.price,
        c.balance,
        c.insert_dt,
        SYSDATE
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_product_info;
END pkg_etl_insert_product_info;
/