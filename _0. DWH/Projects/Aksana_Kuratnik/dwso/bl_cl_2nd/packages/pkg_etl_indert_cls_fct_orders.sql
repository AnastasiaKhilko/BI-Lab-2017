CREATE OR REPLACE PACKAGE pkg_etl_insert_orders
AUTHID CURRENT_USER
AS
  PROCEDURE insert_cls_orders;
END pkg_etl_insert_orders;
/
CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_orders
AS  
PROCEDURE insert_cls_orders
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_fct_orders');
DECLARE
     CURSOR rt_cursor IS
            SELECT order_id,
                   cr.order_dt AS order_dt,
                   ce.seller_id AS seller_surr_id,
                   cm.customer_id AS customer_surr_id, 
                   cr.payment_method_id AS payment_method_surr_id,
                   cr.delivery_method_id AS delivery_method_surr_id,
                   cr.product_info_id AS product_surr_id,
                   cr.sum_of_payment AS sum_of_payment,
                   ROUND ( dbms_random.value( 1, 100), 2) AS amount,
                   cr.insert_dt AS insert_dt,
                   SYSDATE AS update_dt
            FROM   bl_3nf.ce_orders cr left join bl_3nf.ce_sellers ce
                                                on cr.seller_id = ce.seller_id
                                         left join bl_3nf.ce_customers cm
                                                on cr.customer_id = cm.customer_id
                                         left join bl_3nf.ce_product_info cpd
                                                on cr.product_info_id = cpd.product_info_id;
   BEGIN
     FOR rt_cursor_val IN rt_cursor LOOP
       INSERT INTO cls_fct_orders (
                                order_id,
                                order_dt,
                                seller_surr_id,
                                customer_surr_id,
                                payment_method_surr_id,
                                delivery_method_surr_id,
                                product_surr_id,
                                amount,
                                sum_of_payment,
                                insert_dt,
                                update_dt
                                       )
            VALUES (
                                rt_cursor_val.order_id,
                                rt_cursor_val.order_dt,
                                rt_cursor_val.seller_surr_id,
                                rt_cursor_val.customer_surr_id,
                                rt_cursor_val.payment_method_surr_id,
                                rt_cursor_val.delivery_method_surr_id,
                                rt_cursor_val.product_surr_id,
                                rt_cursor_val.amount,
                                rt_cursor_val.sum_of_payment,
                                rt_cursor_val.insert_dt,
                                rt_cursor_val.update_dt
                   );
      END LOOP;
   COMMIT;
  END;  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_cls_orders;
END pkg_etl_insert_orders;
/