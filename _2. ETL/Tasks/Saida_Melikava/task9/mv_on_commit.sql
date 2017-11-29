CREATE MATERIALIZED VIEW mv2
REFRESH COMPLETE ON COMMIT
AS
SELECT
  s.store_name,
  p.product_name,
  SUM(price)    AS price,
  SUM(quantity) AS quantity
FROM fct_sales f
INNER JOIN stores s
ON f.store_id=f.store_id
INNER JOIN products p
ON f.product_id=p.product_id
GROUP BY (store_name, product_name);