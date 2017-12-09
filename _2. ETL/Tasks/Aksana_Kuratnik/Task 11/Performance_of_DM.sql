EXPLAIN PLAN FOR 
SELECT DECODE(GROUPING_ID(TO_CHAR(event_dt,'YYYY'), upper(TO_CHAR(event_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(event_dt,'Q'), upper(TO_CHAR(event_dt,'YYYY')
  || '-'
  || TO_CHAR(event_dt,'Mon') ), event_dt), 7, 'GRAND TOTAL FOR '
  || TO_CHAR(event_dt,'YYYY'), ' ') AS YEAR,
  DECODE(GROUPING_ID(TO_CHAR(event_dt,'YYYY'), upper(TO_CHAR(event_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(event_dt,'Q'), upper(TO_CHAR(event_dt,'YYYY')
  || '-'
  || TO_CHAR(event_dt,'Mon') ), event_dt), 3, 'GRAND TOTAL FOR '
  || upper(TO_CHAR(event_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(event_dt,'Q'), ' ') AS quarter,
  DECODE(GROUPING_ID(TO_CHAR(event_dt,'YYYY'), upper(TO_CHAR(event_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(event_dt,'Q'), upper(TO_CHAR(event_dt,'YYYY')
  || '-'
  || TO_CHAR(event_dt,'Mon') ), event_dt), 1, 'GRAND TOTAL FOR '
  || upper(TO_CHAR(event_dt,'YYYY')
  || '-'
  || TO_CHAR(event_dt,'Mon') ), ' ')              AS MONTH,
  DECODE(GROUPING(event_dt), 1, ' ', event_dt)    AS DAY,
  TO_CHAR(SUM(total_cost), '999,999,999,999') AS sales
FROM fct_orders dt
WHERE TO_CHAR(event_dt,'YYYY') = 2016
GROUP BY ROLLUP( TO_CHAR(event_dt,'YYYY'), upper(TO_CHAR(event_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(event_dt,'Q'), upper(TO_CHAR(event_dt,'YYYY')
  || '-'
  || TO_CHAR(event_dt,'Mon') ), event_dt );
SELECT * FROM TABLE (dbms_xplan.display);
  