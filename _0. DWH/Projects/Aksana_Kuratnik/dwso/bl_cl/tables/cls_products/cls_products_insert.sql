--CLS_PRODUCTS_INSERT
TRUNCATE TABLE cls_products;
INSERT INTO cls_products (
                                 product_id,
                                 product_name,
                                 product_type_id,
                                 start_dt,
                                 end_dt,
                                 is_active
                                 )
  SELECT   concat(a.product_id,' ID') as product_id, 
          concat( a.product_name, 'Prod') as product_name,
           b.product_type_id,
           a.start_dt,
           a.end_dt,
           a.is_active
  FROM     wrk_products a LEFT JOIN cls_product_types b 
                                 ON a.product_type = b.product_type_name;

  COMMIT;