SELECT
  CASE
    WHEN GROUPING_id(s.store_district,p.product_genre)=2
    THEN 'Total by all Stores'
    WHEN GROUPING_id(s.store_district,p.product_genre)=3
    THEN 'GRAND TOTAL'
    ELSE s.store_district
  END AS store_district,
  CASE
    WHEN GROUPING_id(s.store_district,p.product_genre)=1
    THEN 'Total by all Products'
    WHEN GROUPING_id(s.store_district,p.product_genre)=3
    THEN ' '
    ELSE p.product_genre
  END           AS product_genre,
  SUM(fct_sales_amount_byn)    AS price,
  SUM(fct_quantity) AS quantity
FROM fct_sales f
INNER JOIN dim_stores_scd s
ON f.fct_store_dist_id=s.store_district_id
INNER JOIN dim_products p
ON f.fct_product_id=p.product_sur_id
GROUP BY cube(store_district, product_genre)
