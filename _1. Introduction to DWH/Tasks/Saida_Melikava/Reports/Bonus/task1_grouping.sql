SELECT DECODE(GROUPING(calendar_month_desc),1, 'GRAND TOTAL', calendar_month_desc) AS YEAR_MONTH,
  CASE
    WHEN GROUPING_id(calendar_month_desc, channel_desc)=1
    THEN 'Total by Channels'
    WHEN sh.channels.channel_desc IS NULL
    THEN' '
    ELSE sh.channels.channel_desc
  END AS Channel,
  CASE
    WHEN grouping_id(sh.channels.channel_desc,sh.countries.country_name)=1
    THEN sh.channels.channel_desc
      || ' Total By States'
    WHEN sh.countries.country_name IS NULL
    THEN' '
    ELSE sh.countries.country_name
  END                     AS Country,
  ROUND(MAX(amount_sold)) AS MAX_SALES$,
  ROUND(MIN(amount_sold)) AS MIN_SALES$,
  ROUND(SUM(amount_sold)) AS SALES$
FROM sh.sales
LEFT JOIN sh.channels
ON sh.sales.channel_id=sh.channels.channel_id
LEFT JOIN sh.times
ON sh.sales.time_id=sh.times.time_id
LEFT JOIN sh.customers
ON sh.sales.cust_id=sh.customers.cust_id
LEFT JOIN sh.countries
ON sh.customers.country_id=sh.countries.country_id
WHERE calendar_month_desc ='2000-12'
AND (channel_desc         = 'Internet'
OR channel_desc           = 'Direct Sales')
GROUP BY ROLLUP(calendar_month_desc, channel_desc, country_name);
