SELECT (
  CASE
    WHEN grouping (country_description)=1
    AND grouping (product_name)        =0
    THEN 'Total_countries'
    WHEN grouping (country_description)=1
    AND grouping (product_name)        =1
    THEN 'GRAND_TOTAL'
    ELSE country_description
  END) AS country,
  (
  CASE
    WHEN grouping (country_description)=0
    AND grouping (product_name)        =1
    THEN 'Total_products'
    WHEN grouping (country_description)=1
    AND grouping (product_name)        =1
    THEN 'GRAND_TOTAL'
    ELSE product_name
  END) AS product,
  SUM(summ),
  SUM(amount)
FROM fct_sales f
JOIN dim_times t
ON f.sales_date=t.date_id
JOIN products p
ON f.product_id=p.product_id
JOIN ce_countries cc
ON cc.country_id=f.country_id
WHERE sales_date=:p
GROUP BY cube (product_name, country_description) ;


