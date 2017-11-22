-- Adhoc SQL script with CUBE.
SELECT pr.color, 
       fct.event_dt as date_dt, 
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales
FROM   dim_products_scd pr, fct_retail_sales_dd fct
WHERE  pr.product_surr_id = fct.product_surr_id 
  AND extract(day from fct.event_dt) = :day
  AND  pr.product_desc like :product
GROUP BY CUBE(pr.color,
              fct.event_dt)
ORDER BY pr.color NULLS LAST,
         fct.event_dt; 
         
-- Adhoc SQL script with ROLLUP.
SELECT pr.color, 
       cst.country,
       fct.event_dt as date_dt, 
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales
FROM   dim_products_scd pr, fct_retail_sales_dd fct, dim_customers_scd cst
WHERE  pr.product_surr_id = fct.product_surr_id 
  AND  cst.customer_surr_id = fct.customer_surr_id
  AND extract(day from fct.event_dt) = :day
  AND  pr.product_desc like :product
GROUP BY ROLLUP(pr.color,
                cst.country,
                fct.event_dt)
ORDER BY pr.color NULLS LAST,
         fct.event_dt; 
         
-- Adhoc SQL script with GROUPING.
SELECT DECODE(GROUPING(pr.color), 1, 'All Colors', pr.color) AS color,
       DECODE(GROUPING(cst.country), 1, 'All Countries', cst.country) AS country,
       fct.event_dt as date_dt, 
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales
FROM   dim_products_scd pr, fct_retail_sales_dd fct, dim_customers_scd cst
WHERE  pr.product_surr_id = fct.product_surr_id 
  AND  cst.customer_surr_id = fct.customer_surr_id
  AND extract(day from fct.event_dt) = :day
  AND  pr.product_desc like :product
GROUP BY ROLLUP(pr.color,
                cst.country,
                fct.event_dt)
ORDER BY pr.color NULLS LAST,
         fct.event_dt; 
         
-- Adhoc SQL script with GROUPING_ID.
SELECT cst.country,
       fct.event_dt as date_dt, 
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales,
       GROUPING_ID(pr.color, cst.country) AS grouping_col_amount
FROM   dim_products_scd pr, fct_retail_sales_dd fct, dim_customers_scd cst
WHERE  pr.product_surr_id = fct.product_surr_id 
  AND  cst.customer_surr_id = fct.customer_surr_id
  AND extract(day from fct.event_dt) = :day
  AND  pr.product_desc like :product
GROUP BY ROLLUP(pr.color,
                cst.country,
                fct.event_dt); 