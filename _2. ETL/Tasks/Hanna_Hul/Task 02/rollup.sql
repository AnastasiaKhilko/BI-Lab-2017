SELECT
  dim_date.year_id,
  dim_date.Quarter_ID,
  NVL(dim_date.month_long,' '),
  dim_date.Day_Num_of_Month,
  SUM(amount*discount/100)
FROM
  fact_order,
  dim_date
WHERE --fact_order.location_id = dim_locations.location_id AND
  fact_order.date_id           = dim_date.date_id
AND dim_date.year_id          >= 2017
AND dim_date.day_num_of_month <= 3
GROUP BY
  dim_date.year_id,
  ROLLUP(dim_date.Quarter_ID, dim_date.month_long, dim_date.Day_Num_of_Month);
--order by grouping_id(dim_locations.country),2,1; 