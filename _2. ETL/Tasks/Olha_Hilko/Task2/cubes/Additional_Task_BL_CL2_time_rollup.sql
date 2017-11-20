--the proc was developed in the 8th lab
--EXEC Proc_DimDate_Recreate('DimDateTable', to_date('01.01.2014', 'DD.MM.YYYY'),  to_date('31.12.2017', 'DD.MM.YYYY'), TRUE);
--select * from DimDateTable order by date_id;
--select * from CL_PAYMENT order by payment_date;
/*the tables were joined as is : the are ought to be on DWH layer
that is why trunc(date) is used to join*/
SELECT --TO_CHAR(year), TO_CHAR(quarter), TO_CHAR(month), TO_CHAR(date_id),
  (CASE
    WHEN grouping_id (year, quarter, month, date_id)=15
   THEN 'Всего за период: '
    ELSE TO_CHAR(year)
  END) AS year_sales,
  (
  CASE
    WHEN grouping_id (year, quarter, month, date_id)=7
    THEN 'Всего за год: '||TO_CHAR(year)
    ELSE TO_CHAR(quarter)
  END) AS quarter_sales,
  (
  CASE
    WHEN grouping_id (year, quarter, month, date_id)=3
    THEN 'Всего за квартал: '|| TO_CHAR(quarter) ||'-'|| TO_CHAR(year)
    ELSE TO_CHAR(month)
  END) AS month_sales,
  (
  CASE
    WHEN grouping_id (year, quarter, month, date_id)=1
    THEN 'Всего за месяц: '|| TO_CHAR(month) ||'-'|| TO_CHAR(year)
    ELSE TO_CHAR(date_id)
  END) AS date_sales,
  SUM(price)
FROM CL_PAYMENT p
JOIN DIMDATETABLE d
ON trunc(p.payment_date)=trunc(d.date_id)
GROUP BY ROLLUP(year, quarter, month, date_id);