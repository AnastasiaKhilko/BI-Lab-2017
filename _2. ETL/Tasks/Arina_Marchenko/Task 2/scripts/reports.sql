SELECT p.prod_category,
  fct.event_dt,
  TO_CHAR(SUM(fct.total_price),'9,999,999,999') AS Sales
FROM dim_prod p,
  fct_table fct
WHERE p.prod_id                    = fct.prod_id
AND extract(YEAR FROM fct.event_dt)=2017
GROUP BY CUBE(p.prod_category, fct.event_dt)
ORDER BY p.prod_category NULLS LAST;

SELECT DECODE(GROUPING( s.channel_desc),1,'All channels', s.channel_desc) AS channel,
  DECODE(GROUPING( p.prod_category),1,'All categories', p.prod_category)  AS categories,
  fct.event_dt,
  TO_CHAR(SUM(fct.total_price),'9,999,999,999') AS Sales
FROM dim_channels s,
  fct_table fct,
  dim_prod p
WHERE s.channel_id = fct.channel_id
AND fct.prod_id    =p.prod_id
GROUP BY ROLLUP(s.channel_desc, p.prod_category, fct.event_dt)
ORDER BY s.channel_desc,
  p.prod_category NULLS LAST;
