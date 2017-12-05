EXPLAIN PLAN FOR 
SELECT
  CASE
    WHEN GROUPING_id(s.customer_district,p.product_genre)=2
    THEN 'Total by all Stores'
    WHEN GROUPING_id(s.customer_district,p.product_genre)=3
    THEN 'GRAND TOTAL'
    ELSE s.customer_district
  END AS customer_district,
  CASE
    WHEN GROUPING_id(s.customer_district,p.product_genre)=1
    THEN 'Total by all Products'
    WHEN GROUPING_id(s.customer_district,p.product_genre)=3
    THEN ' '
    ELSE p.product_genre
  END           AS product_genre,
  SUM(fct_sales_amount_byn)    AS price,
  SUM(fct_quantity) AS quantity
FROM fct_sales f
LEFT JOIN dim_customers s
ON f.fct_customer_id=s.customer_sur_id
LEFT JOIN dim_products p
ON f.fct_product_id=p.product_sur_id
--group by rollup(customer_district, product_genre)
GROUP BY cube(customer_district, product_genre);

SELECT * FROM TABLE(dbms_xplan.display);