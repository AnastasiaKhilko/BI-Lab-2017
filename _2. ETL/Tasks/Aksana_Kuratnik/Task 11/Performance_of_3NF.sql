EXPLAIN PLAN FOR 
SELECT DECODE(GROUPING_ID(TO_CHAR(order_dt,'YYYY'), upper(TO_CHAR(order_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(order_dt,'Q'), upper(TO_CHAR(order_dt,'YYYY')
  || '-'
  || TO_CHAR(order_dt,'Mon') ), order_dt), 7, 'GRAND TOTAL FOR '
  || TO_CHAR(order_dt,'YYYY'), ' ') AS YEAR,
  DECODE(GROUPING_ID(TO_CHAR(order_dt,'YYYY'), upper(TO_CHAR(order_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(order_dt,'Q'), upper(TO_CHAR(order_dt,'YYYY')
  || '-'
  || TO_CHAR(order_dt,'Mon') ), order_dt), 3, 'GRAND TOTAL FOR '
  || upper(TO_CHAR(order_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(order_dt,'Q'), ' ') AS quarter,
  DECODE(GROUPING_ID(TO_CHAR(order_dt,'YYYY'), upper(TO_CHAR(order_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(order_dt,'Q'), upper(TO_CHAR(order_dt,'YYYY')
  || '-'
  || TO_CHAR(order_dt,'Mon') ), order_dt), 1, 'GRAND TOTAL FOR '
  || upper(TO_CHAR(order_dt,'YYYY')
  || '-'
  || TO_CHAR(order_dt,'Mon') ), ' ')              AS MONTH,
  DECODE(GROUPING(order_dt), 1, ' ', order_dt)    AS DAY,
  TO_CHAR(SUM(sum_of_payment), '999,999,999,999') AS sales
FROM ce_orders dt
WHERE TO_CHAR(order_dt,'YYYY') = 2016
GROUP BY ROLLUP( TO_CHAR(order_dt,'YYYY'), upper(TO_CHAR(order_dt,'YYYY'))
  || '-'
  || 'Q'
  || TO_CHAR(order_dt,'Q'), upper(TO_CHAR(order_dt,'YYYY')
  || '-'
  || TO_CHAR(order_dt,'Mon') ), order_dt );
  SELECT * FROM TABLE (dbms_xplan.display);