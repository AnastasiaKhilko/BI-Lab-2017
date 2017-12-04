SELECT (
  CASE
    WHEN grouping_id (dateyear, datequarteryear, datemonth, date_id)=15
    THEN 'GRAND_TOTAL'
    ELSE TO_CHAR(dateyear)
  END) AS year_sales,
  (
  CASE
    WHEN grouping_id (dateyear, datequarteryear, datemonth, date_id)=7
    THEN 'TOTAL_YEAR'
    ELSE TO_CHAR(datequarteryear)
  END) AS quarter_sales,
  (
  CASE
    WHEN grouping_id (dateyear, datequarteryear, datemonth, date_id)=3
    THEN 'TOTAL_QUARTER'
    ELSE TO_CHAR(datemonth)
  END) AS month_sales,
  (
  CASE
    WHEN grouping_id (dateyear, datequarteryear, datemonth, date_id)=1
    THEN 'TOTAL_MONTH'
    ELSE TO_CHAR(date_id)
  END) AS date_sales,
  SUM(summ),
  SUM(amount)
FROM fct_sales f
JOIN dim_times t
ON f.sales_date=t.date_id
GROUP BY ROLLUP(dateyear, datequarteryear, datemonth, date_id);