--CLS_PRODUCT_TYPES_INSERT
TRUNCATE TABLE cls_product_types;
INSERT INTO cls_product_types (
                                 product_type_id,
                                 product_type_name,
                                 category_id,
                                 start_dt,
                                 is_active
                                 )
  SELECT   SUBSTR(product_type, 1,10) || TRUNC(dbms_random.value(1,1000000)) as product_type_id,
           NVL(a.product_type, 'NO TYPE') AS product_type,
           b.category_id,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     (SELECT DISTINCT product_type, category_name
           FROM wrk_products) a left join cls_categories b 
                                       ON a.category_name = b.category_name WHERE b.category_id IS NOT NULL;

  COMMIT;