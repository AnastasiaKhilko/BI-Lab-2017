--CLS_ORDERS_INSERT
INSERT
INTO cls_orders
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
SELECT order_id,
  order_dt,
  seller_id,
  customer_id,
  payment_method_id,
  delivery_method_id,
  product_info_id,
  sum_of_payment,
  SYSDATE AS insert_dt
FROM
  (SELECT TRUNC(dbms_random.value(100000000000, 9999999999999)) AS order_id ,
    TRUNC ( (sysdate +4) - dbms_random.value ( 1, 1000 ) )      AS order_dt,
    ROUND ( dbms_random.value (
    (SELECT MIN ( seller_id)
    FROM bl_3nf.ce_sellers
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ),
    (SELECT MAX ( seller_id)
    FROM bl_3nf.ce_sellers
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ))) AS seller_id,
    ROUND ( dbms_random.value (
    (SELECT MIN ( customer_id )
    FROM bl_3nf.ce_customers
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ),
    (SELECT MAX ( customer_id )
    FROM bl_3nf.ce_customers
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ) ) ) AS customer_id,
    ROUND ( dbms_random.value (
    (SELECT MIN ( payment_method_id )
    FROM bl_3nf.ce_payment_methods
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ),
    (SELECT MAX ( payment_method_id )
    FROM bl_3nf.ce_payment_methods
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ) ) ) AS payment_method_id,
    ROUND ( dbms_random.value (
    (SELECT MIN ( delivery_method_id )
    FROM bl_3nf.ce_delivery_methods
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ),
    (SELECT MAX ( delivery_method_id )
    FROM bl_3nf.ce_delivery_methods
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ) ) ) AS delivery_method_id,
    ROUND ( dbms_random.value (
    (SELECT MIN ( product_info_id )
    FROM bl_3nf.ce_product_info a
    INNER JOIN bl_3nf.ce_products b
    ON a.product_srcid                      = b.product_srcid
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ),
    (SELECT MAX ( product_info_id )
    FROM bl_3nf.ce_product_info a
    INNER JOIN bl_3nf.ce_products b
    ON a.product_srcid                      = b.product_srcid
    WHERE UPPER(SUBSTR(TRIM(is_active),1,4))='TRUE'
    ) ) )                                      AS product_info_id,
    ROUND ( dbms_random.value( 100, 99999), 2) AS sum_of_payment
  FROM
    (SELECT * FROM dual CONNECT BY level <1000000
    )
  );