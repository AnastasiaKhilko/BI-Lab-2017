SELECT
  CASE
    WHEN GROUPING_id(d.year_number,d.quarter_number,d.month_number,event_dt)=1
    THEN 'Total by month number '
      ||d.month_number
    ELSE TO_CHAR(event_dt)
  END AS event_dt,
  CASE
    WHEN GROUPING_id(d.year_number,d.quarter_number,d.month_number,event_dt)=3
    THEN 'Total by quarte number '
      ||d.quarter_number
    ELSE TO_CHAR(month_number)
  END AS month_number,
  CASE
    WHEN GROUPING_id(d.year_number,d.quarter_number,d.month_number,event_dt)=7
    THEN 'Total by year '
      ||d.year_number
    ELSE TO_CHAR(quarter_number)
  END AS quarter_number,
  CASE
    WHEN GROUPING_id(d.year_number,d.quarter_number,d.month_number,event_dt)=15
    THEN 'GRAND TOTAL '
      ||d.year_number
    ELSE TO_CHAR(year_number)
  END AS year_number,
  SUM(price), sum(quantity),
  grouping_id(d.year_number,d.quarter_number,d.month_number,event_dt) AS gr
FROM fct_sales f
LEFT JOIN dim_time_day d
ON f.event_dt=to_date(d.full_date_dt)
GROUP BY rollup(d.year_number,d.quarter_number,d.month_number,event_dt)
ORDER BY gr DESC;
