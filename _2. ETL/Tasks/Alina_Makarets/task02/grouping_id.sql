SELECT p.category_name,
       s.country_region,
       fct.event_date,
       TO_CHAR(SUM(fct.total_price),'9,999,999,999') as Sales,
       GROUPING_ID (p.category_name, s.country_region) as grouping_id
FROM dim_stores s, 
     fct_table fct,
     dim_products p
WHERE s.store_id = fct.store_id
AND p.product_id=fct.product_id
AND extract(year from fct.event_date)=2017
GROUP BY ROLLUP(p.category_name,
                 s.country_region,
                 fct.event_date);