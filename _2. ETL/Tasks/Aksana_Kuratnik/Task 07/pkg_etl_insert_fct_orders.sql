CREATE OR REPLACE PACKAGE pkg_etl_insert_fct_orders
AUTHID CURRENT_USER
AS
  PROCEDURE insert_fct_orders; 
END pkg_etl_insert_fct_orders;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_fct_orders
AS
PROCEDURE insert_fct_orders
IS
BEGIN
   INSERT INTO  
             bl_dm.fct_orders
   SELECT    
             bl_dm.fct_orders_seq.NEXTVAL AS sale_id,
             a.order_id,
             a.order_dt,
             c.seller_surr_id,
             b.customer_surr_id,
             e.payment_method_id,
             g.delivery_method_id,
             f.product_surr_id,
             a.sum_of_payment,
             a.insert_dt,
             a.update_dt 
      FROM   cls_fct_orders a INNER JOIN bl_dm.dim_customers b ON a.customer_surr_id = b.customer_id
                                       INNER JOIN bl_dm.dim_sellers_ c ON a.seller_surr_id = c.seller_id
                                       INNER JOIN bl_dm.dim_payment_methods e ON a.payment_method_surr_id = e.payment_method_id
                                       INNER JOIN bl_dm.dim_products f ON a.product_surr_id = f.product_id
                                       INNER JOIN bl_dm.dim_delivery_methods g ON a.delivery_method_surr_id = g.delivery_method_id;
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    RAISE;
END insert_fct_orders;
END pkg_etl_insert_fct_orders;
/