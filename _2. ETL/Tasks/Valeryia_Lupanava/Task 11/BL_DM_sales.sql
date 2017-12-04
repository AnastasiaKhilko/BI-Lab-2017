EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (OWNNAME =>'bl_dm',CASCADE => TRUE);

SET TIMING ON

EXPLAIN PLAN FOR 
SELECT DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 7, 'GRAND TOTAL FOR ' || dt.year, ' ') AS year,
       DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 3, 'GRAND TOTAL FOR ' || dt.quarter_year, ' ') AS quarter,
       DECODE(GROUPING_ID(dt.year, dt.quarter_year, dt.month_year, event_dt), 1, 'GRAND TOTAL FOR ' || dt.month_year, ' ') AS month,
       DECODE(GROUPING(event_dt), 1, ' ', event_dt) AS day,
       TO_CHAR(SUM(fct.tot_sale_sum), '9,999,999,999') as sales
FROM   fct_retail_sales_dd fct, 
       dim_time_day dt
WHERE  dt.date_dt = fct.event_dt
  AND  dt.year = 2018
GROUP BY ROLLUP(
                dt.year,
                dt.quarter_year,
                dt.month_year,
                event_dt                       
);


SELECT * FROM TABLE (dbms_xplan.display);