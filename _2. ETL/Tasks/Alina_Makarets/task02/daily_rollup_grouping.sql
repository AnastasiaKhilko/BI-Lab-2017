SELECT DECODE(GROUPING( s.country_region),1,'All countries', s.country_region) as region,
       DECODE(GROUPING( p.category_name),1,'All categories', p.category_name) as categories,
       fct.event_date,
       TO_CHAR(SUM(fct.total_price),'9,999,999,999') as Sales
FROM dim_stores s, 
     fct_table fct,
     dim_products p
WHERE s.store_id = fct.store_id
AND fct.product_id=p.product_id
GROUP BY ROLLUP(s.country_region,
      p.category_name,
      fct.event_date)
ORDER BY s.country_region,
        p.category_name NULLS LAST;