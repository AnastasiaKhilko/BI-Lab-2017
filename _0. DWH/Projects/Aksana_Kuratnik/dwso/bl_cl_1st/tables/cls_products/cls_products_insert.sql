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
  SELECT   concat(product_id,rownum) as product_id, 
           SUBSTR(a.product_name, 1,25) as product_name,
           b.product_type_id,
           a.start_dt,
           a.end_dt,
           a.is_active
  FROM     wrk_products a  LEFT JOIN cls_product_types b 
                                 ON a.product_type = b.product_type_name 
          WHERE product_name is not null AND product_id IS NOT NULL and product_type is not null;

  COMMIT;