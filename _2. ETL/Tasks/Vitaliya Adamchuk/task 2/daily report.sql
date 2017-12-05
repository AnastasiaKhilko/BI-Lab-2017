SELECT
  CASE
    WHEN GROUPING_id(s.store_name,p.product_name)=2
    THEN 'Total by all Stores'
    WHEN GROUPING_id(s.store_name,p.product_name)=3
    THEN 'GRAND TOTAL'
    ELSE s.store_name
  END AS store_name,
  CASE
    WHEN GROUPING_id(s.store_name,p.product_name)=1
    THEN 'Total by all Products'
    WHEN GROUPING_id(s.store_name,p.product_name)=3
    THEN ' '
    ELSE p.product_name
  END           AS product_name,
  SUM(price)    AS price,
  SUM(quantity) AS quantity
FROM fct_sales f
INNER JOIN stores s
ON f.store_id=f.store_id
INNER JOIN products p
ON f.product_id=p.product_id
  --group by rollup(store_name, product_name)
GROUP BY cube(store_name, product_name)
