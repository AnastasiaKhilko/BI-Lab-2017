SELECT DECODE(GROUPING_ID(dtd.year, dtd.year_quater, event_date), 7, 'GRAND TOTAL FOR ' || dtd.year, ' ') AS year,
       DECODE(GROUPING_ID(dtd.year, dtd.year_quater, event_date), 3, 'GRAND TOTAL FOR ' || dtd.year_quater, ' ') AS quarter,
       DECODE(GROUPING(event_date), 1, ' ', event_date) AS day,
       TO_CHAR(SUM(fct.total_price), '9,999,999,999') as sales
FROM   dim_products p, 
       Fct_table fct, 
       dim_time_day dtd
WHERE  p.product_id = fct.product_id 
  AND  dtd.date_id = fct.event_date
GROUP BY ROLLUP(
                dtd.year,
                dtd.year_quater,
                event_date                       
);
