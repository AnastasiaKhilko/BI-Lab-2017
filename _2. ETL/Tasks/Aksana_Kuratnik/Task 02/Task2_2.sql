SELECT
  CASE
    WHEN GROUPING_id(d.year,d.quarter_of_year,d.month_of_year,order_dt)=1
    THEN 'Total by month number '
      ||d.month_of_year
    ELSE TO_CHAR(order_dt)
  END AS order_dt,
  CASE
    WHEN GROUPING_id(d.year,d.quarter_of_year,d.month_of_year,order_dt)=3
    THEN 'Total by quarter number '
      ||d.quarter_of_year
    ELSE TO_CHAR(month_of_year)
  END AS month_of_year,
  CASE
    WHEN GROUPING_id(d.year,d.quarter_of_year,d.month_of_year,order_dt)=7
    THEN 'Total by year '
      ||d.year
    ELSE TO_CHAR(quarter_of_year)
  END AS quarter_of_year,
  CASE
    WHEN GROUPING_id(d.year,d.quarter_of_year,d.month_of_year,order_dt)=15
    THEN 'GRAND TOTAL '
      ||d.year
    ELSE TO_CHAR(YEAR)
  END AS YEAR,
  SUM(sum_of_payment),
  grouping_id(d.year,d.quarter_of_year,d.month_of_year,order_dt) AS gr
FROM cls_orders f
LEFT JOIN bl_dm.dim_date d
ON f.order_dt=to_date(d.date_id)
GROUP BY rollup(d.year,d.quarter_of_year,d.month_of_year,order_dt);
--ORDER BY gr DESC;
