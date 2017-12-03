--CLS_CATEGORIES_INSERT
TRUNCATE TABLE cls_categories;
INSERT INTO cls_categories(
                                 category_id,
                                 category_name,
                                 start_dt,
                                 is_active
                                 )
  SELECT   SUBSTR(category_name,1,3)||'C' as category_id,
           category_name,
           SYSDATE AS start_dt,
           'TRUE' AS is_active
  FROM     (SELECT DISTINCT category_name
            FROM wrk_products);

  COMMIT;
