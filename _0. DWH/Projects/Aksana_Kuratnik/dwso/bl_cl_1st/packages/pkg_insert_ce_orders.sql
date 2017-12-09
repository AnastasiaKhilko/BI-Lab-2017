CREATE OR REPLACE PACKAGE pkg_etl_insert_orders
AUTHID CURRENT_USER
AS
  PROCEDURE merge_ce_orders;				
END pkg_etl_insert_orders;
/

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_orders
AS

PROCEDURE merge_ce_orders
IS
BEGIN

MERGE INTO bl_3nf.ce_orders t USING
    ( SELECT order_id,
             order_dt,
             seller_id,
             customer_id,
             payment_method_id,
             delivery_method_id,
             product_info_id,
             sum_of_payment,
             insert_dt
      FROM   cls_orders
    MINUS
      SELECT order_id,
             order_dt,
             seller_id,
             customer_id,
             payment_method_id,
             delivery_method_id,
             product_info_id,
             sum_of_payment,
             insert_dt 
      FROM   bl_3nf.ce_orders
    ) c ON (  
             c.order_id = t.order_id
       AND   c.insert_dt = t.insert_dt
       AND   c.order_dt = t.order_dt
       AND   c.customer_id = t.customer_id
       AND   c.seller_id = t.seller_id
       AND   c.sum_of_payment = t.sum_of_payment
       AND   c.product_info_id = t.product_info_id
       )
    WHEN NOT matched THEN
    INSERT
      (
        order_id,
        order_dt,
        seller_id,
        customer_id,
        payment_method_id,
        delivery_method_id,
        product_info_id,
        sum_of_payment,
        insert_dt 
      )
      VALUES
      (
        c.order_id,
        c.order_dt,
        c.seller_id,
        c.customer_id,
        c.payment_method_id,
        c.delivery_method_id,
        c.product_info_id,
        c.sum_of_payment,
        c.insert_dt
      ) ;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END merge_ce_orders;
---------------------------------------------------
END pkg_etl_insert_orders;