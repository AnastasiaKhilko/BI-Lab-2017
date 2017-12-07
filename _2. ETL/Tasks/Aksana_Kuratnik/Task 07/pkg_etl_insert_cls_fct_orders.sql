CREATE OR REPLACE PACKAGE pkg_etl_insert_cls_orders
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_orders; 
END pkg_etl_insert_cls_orders;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_cls_orders
AS
PROCEDURE insert_cls_orders
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_fct_orders');
INSERT INTO cls_fct_retail_sales_dd
SELECT order_id,
       cr.order_dt AS event_dt,
       ce.seller_id AS seller_surr_id,
       cm.customer_id AS customer_surr_id, 
       ct.store_id AS store_id,
       cr.payment_method_id AS payment_method_surr_id,
       cr.delivery_method_id AS delivery_method_surr_id,
       cr.product_info_id AS product_info_surr_id,
       cr.order_sum_usd AS tot_sale_sum,
       ROUND ( dbms_random.value( 100, 99999), 2) AS tot_sale_amount,
       cr.insert_dt AS insert_dt,
       SYSDATE AS update_dt
FROM   bl_3nf.ce_orders cr left join bl_3nf.ce_sellers ce
                                    on cr.seller_id = ce.seller_id
                             left join bl_3nf.ce_customers cm
                                    on cr.customer_id = cm.customer_id
                             left join bl_3nf.ce_stores ct
                                    on cr.store_id = ct.store_id
                             left join bl_3nf.ce_product_info cpd
                                    on cr.product_info_id = cpd.product_info_id;
COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
END insert_cls_orders;
END pkg_etl_insert_cls_orders;
/