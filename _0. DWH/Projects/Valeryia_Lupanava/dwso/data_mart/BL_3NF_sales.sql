EXECUTE dbms_stats.gather_schema_stats (ownname =>'bl_3nf',CASCADE => TRUE);

SET TIMING ON

EXPLAIN PLAN FOR 
SELECT DECODE(GROUPING_ID(to_char(receipt_dt,'YYYY'), 
                          upper(TO_CHAR(receipt_dt,'YYYY')) || '-' || 'Q' || TO_CHAR(receipt_dt,'Q'), 
                          upper(TO_CHAR(receipt_dt,'YYYY') || '-' || TO_CHAR(receipt_dt,'Mon') ), receipt_dt), 7, 
                          'GRAND TOTAL FOR ' || to_char(receipt_dt,'YYYY'), ' ') AS year,
       DECODE(GROUPING_ID(to_char(receipt_dt,'YYYY'), 
                          upper(TO_CHAR(receipt_dt,'YYYY')) || '-' || 'Q' || TO_CHAR(receipt_dt,'Q'), 
                          upper(TO_CHAR(receipt_dt,'YYYY') || '-' || TO_CHAR(receipt_dt,'Mon') ), receipt_dt), 3, 
                          'GRAND TOTAL FOR ' || upper(TO_CHAR(receipt_dt,'YYYY')) || '-' || 'Q' || TO_CHAR(receipt_dt,'Q'), ' ') AS quarter,
       DECODE(GROUPING_ID(to_char(receipt_dt,'YYYY'), 
                          upper(TO_CHAR(receipt_dt,'YYYY')) || '-' || 'Q' || TO_CHAR(receipt_dt,'Q'), 
                          upper(TO_CHAR(receipt_dt,'YYYY') || '-' || TO_CHAR(receipt_dt,'Mon') ), receipt_dt), 1, 
                          'GRAND TOTAL FOR ' || upper(TO_CHAR(receipt_dt,'YYYY') || '-' || TO_CHAR(receipt_dt,'Mon') ), ' ') AS month,
       DECODE(GROUPING(receipt_dt), 1, ' ', receipt_dt) AS day,
       TO_CHAR(SUM(receipt_sum_usd), '9,999,999,999') as sales
FROM   ce_receipts dt
WHERE  to_char(receipt_dt,'YYYY') = 2018
GROUP BY ROLLUP(
                to_char(receipt_dt,'YYYY'),
                upper(TO_CHAR(receipt_dt,'YYYY')) || '-' || 'Q' || TO_CHAR(receipt_dt,'Q'),
                upper(TO_CHAR(receipt_dt,'YYYY') || '-' || TO_CHAR(receipt_dt,'Mon') ),
                receipt_dt                       
);

SELECT * FROM TABLE (dbms_xplan.display);