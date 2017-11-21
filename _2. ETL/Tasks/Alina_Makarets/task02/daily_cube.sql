SELECT p.category_name,
      fct.event_date,
      TO_CHAR(SUM(fct.total_price),'9,999,999,999') as Sales
FROM dim_products p, 
     fct_table fct
WHERE p.product_id = fct.product_id
AND extract(YEAR FROM fct.event_date)=2017
GROUP BY CUBE(p.category_name,
              fct.event_date)
ORDER BY p.category_name NULLS LAST;