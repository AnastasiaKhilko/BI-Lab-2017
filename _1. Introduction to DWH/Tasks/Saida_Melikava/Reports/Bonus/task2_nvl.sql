WITH quarter AS
  ( SELECT DISTINCT sh.products.prod_name                                                                                                                                AS prod_name,
    NTH_VALUE(SUM(AMOUNT_SOLD),1) OVER (PARTITION BY prod_name ORDER BY sh.times .calendar_quarter_number ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q1,
    NTH_VALUE(SUM(AMOUNT_SOLD),2) OVER (PARTITION BY prod_name ORDER BY sh.times .calendar_quarter_number ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q2,
    NTH_VALUE(SUM(AMOUNT_SOLD),3) OVER (PARTITION BY prod_name ORDER BY sh.times .calendar_quarter_number ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q3,
    NTH_VALUE(SUM(AMOUNT_SOLD),4) OVER (PARTITION BY prod_name ORDER BY sh.times .calendar_quarter_number ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q4,
    SUM(SUM(AMOUNT_SOLD)) OVER (PARTITION BY prod_name)                                                                                                                  AS YEAR_SUM
  FROM sh.sales
  LEFT JOIN sh.products
  ON sh.sales.prod_id=sh.products.prod_id
  LEFT JOIN sh.times
  ON sh.sales.time_id=sh.times.time_id
  LEFT JOIN sh.channels
  ON sh.sales.channel_id=sh.channels.channel_id
  LEFT JOIN sh.customers
  ON sh.sales.cust_id=sh.customers.cust_id
  LEFT JOIN sh.countries
  ON sh.customers.country_id   =sh.countries.country_id
  WHERE sh.times.calendar_year ='2000'
  AND country_region           ='Asia'
  AND prod_category            ='Photo'
  GROUP BY sh.products.prod_name,
    sh.times .calendar_quarter_number
  )
SELECT NVL(sh.products.prod_name,'TOTAL') AS Prod_name,
  SUM(Q1)                                 AS Q1,
  SUM(Q2)                                 AS Q2,
  SUM(Q3)                                 AS Q3,
  SUM(Q4)                                 AS Q4,
  SUM(year_sum)
FROM quarter q
LEFT JOIN sh.products
ON q.prod_name=sh.products.prod_name
GROUP BY rollup(sh.products.prod_name) ;