SELECT NVL(PROD_NAME,'TOTAL') AS PRODUCT_NAME, SUM(Q1) AS Q1, SUM(Q2) AS Q2,  SUM(Q3) AS Q3,
      SUM(Q4) AS Q4, SUM(YEAR_SUM) AS YEAR_SUM
FROM
        (SELECT DISTINCT PRODUCTS.PROD_NAME,
                NTH_VALUE(SUM(AMOUNT_SOLD),1) OVER (PARTITION BY PRODUCTS.PROD_NAME ORDER BY TIMES.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q1,
                NTH_VALUE(SUM(AMOUNT_SOLD),2) OVER (PARTITION BY PRODUCTS.PROD_NAME ORDER BY TIMES.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q2, 
                NTH_VALUE(SUM(AMOUNT_SOLD),3) OVER (PARTITION BY PRODUCTS.PROD_NAME ORDER BY TIMES.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q3,
                NTH_VALUE(SUM(AMOUNT_SOLD),4) OVER (PARTITION BY PRODUCTS.PROD_NAME ORDER BY TIMES.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Q4,
                SUM(SUM(AMOUNT_SOLD)) OVER (PARTITION BY PRODUCTS.PROD_NAME) AS YEAR_SUM
        FROM PRODUCTS, TIMES, SALES, COUNTRIES, CUSTOMERS
        WHERE SALES.TIME_ID=TIMES.TIME_ID and SALES.CUST_ID=CUSTOMERS.CUST_ID and
              SALES.PROD_ID=PRODUCTS.PROD_ID and  CUSTOMERS.COUNTRY_ID=COUNTRIES.COUNTRY_ID and
              PRODUCTS.PROD_CATEGORY='Photo' and TIMES.CALENDAR_YEAR=2000 and COUNTRIES.COUNTRY_SUBREGION='Asia'
        GROUP BY  PRODUCTS.PROD_NAME, TIMES.CALENDAR_QUARTER_NUMBER)
GROUP BY ROLLUP(PROD_NAME);
