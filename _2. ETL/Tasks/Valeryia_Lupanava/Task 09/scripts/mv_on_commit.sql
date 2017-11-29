CREATE MATERIALIZED VIEW vsales_by_customers_c
REFRESH FAST
ON COMMIT
ENABLE QUERY REWRITE
AS SELECT customer_surr_id, country, receipts_sum
FROM sales_by_customers
ORDER BY 3 DESC;

DELETE FROM sales_by_customers
WHERE rownum = 1;

SELECT TO_CHAR (SYSDATE, 'DD.MM.YY HH24:MI') AS time, a.* 
FROM  vsales_by_customers_c a
WHERE customer_surr_id = 509099;

COMMIT;

SELECT TO_CHAR (SYSDATE, 'DD.MM.YY HH24:MI') AS time, a.* 
FROM  vsales_by_customers_c a
WHERE customer_surr_id = 509099;