SELECT DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 7, 'GRAND TOTAL FOR ' || dt.year, ' ') AS year,
       DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 3, 'GRAND TOTAL FOR ' || dt.quarter_year, ' ') AS quarter,
       DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 1, 'GRAND TOTAL FOR ' || dt.month_year, ' ') AS month,
       DECODE(GROUPING(event_dt), 1, ' ', event_dt) AS day,
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales
FROM   dim_products_scd pr, 
       fct_retail_sales_dd fct, 
       dim_customers_scd cst, 
       dim_time_day dt
WHERE  pr.product_surr_id = fct.product_surr_id 
  AND  cst.customer_surr_id = fct.customer_surr_id
  AND  dt.date_dt = fct.event_dt
GROUP BY ROLLUP(
                dt.year,
                dt.quarter_year,
                dt.month_year,
                event_dt                       
);