CREATE MATERIALIZED VIEW vsales_by_customers
REFRESH FORCE
ON DEMAND
ENABLE QUERY REWRITE
AS SELECT *
FROM sales_by_customers
ORDER BY 5 DESC;

BEGIN
  DBMS_STATS.gather_table_stats(
    ownname => 'data_mart',
    tabname => 'vsales_by_customers');
END;
/
BEGIN
   DBMS_REFRESH.make(
     name                 => 'data_mart.minute_refresh',
     list                 => '',
     next_date            => SYSDATE,
     interval             => '/*1:Mins*/ SYSDATE + 1/(60*24)'
                    );
END;
/
BEGIN
   DBMS_REFRESH.add(
     name => 'data_mart.minute_refresh',
     list => 'data_mart.vsales_by_customers',
     lax  => TRUE);
END;
/
EXEC DBMS_MVIEW.refresh('vsales_by_customers');

EXPLAIN PLAN FOR
SELECT *
FROM   sales_by_customers;

SELECT * 
FROM table(dbms_xplan.display);

DELETE FROM sales_by_customers
WHERE rownum = 1;

SELECT TO_CHAR (SYSDATE, 'DD.MM.YY HH24:MI') AS time, a.* 
FROM  vsales_by_customers a
WHERE customer_surr_id = 509098;

EXEC DBMS_MVIEW.refresh('vsales_by_customers');

SELECT TO_CHAR (SYSDATE, 'DD.MM.YY HH24:MI') AS time, a.* 
FROM  vsales_by_customers a
WHERE customer_surr_id = 509098;