CREATE SYNONYM products FOR sh.products;
CREATE SYNONYM times FOR sh.times;
CREATE SYNONYM countries FOR sh.countries;
CREATE SYNONYM customers FOR sh.customers;
CREATE SYNONYM sales FOR sh.sales;
  SELECT DISTINCT
    --decode(grouping_id(products.PROD_NAME),1,'TOTAL',products.PROD_NAME)
    -- prod_name,
    NVL(products.prod_name,'TOTAL') prod_name,
    NTH_VALUE(SUM(AMOUNT_SOLD),1) OVER (PARTITION BY products.PROD_NAME
    ORDER BY times.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED
    PRECEDING AND UNBOUNDED FOLLOWING) AS Q1,
    NTH_VALUE(SUM(AMOUNT_SOLD),2) OVER (PARTITION BY PRoducts.PROD_NAME
    ORDER BY Times.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED
    PRECEDING AND UNBOUNDED FOLLOWING) AS Q2,
    NTH_VALUE(SUM(AMOUNT_SOLD),3) OVER (PARTITION BY products.PROD_NAME
    ORDER BY Times.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED
    PRECEDING AND UNBOUNDED FOLLOWING) AS Q3,
    NTH_VALUE(SUM(AMOUNT_SOLD),4) OVER (PARTITION BY products.PROD_NAME
    ORDER BY Times.CALENDAR_QUARTER_NUMBER ASC RANGE BETWEEN UNBOUNDED
    PRECEDING AND UNBOUNDED FOLLOWING)                           AS Q4,
    SUM(SUM(AMOUNT_SOLD)) OVER (PARTITION BY products.PROD_NAME) AS YEAR_SUM
    --times.fiscal_quarter_number
  FROM
    sales, times, products, customers, countries
  WHERE
    sales.time_id = times.time_id
  AND sales.prod_id = products.prod_id
  AND sales.cust_id = customers.cust_id
  AND customers.country_id = countries.country_id
  AND times.fiscal_year = '2000'
  AND countries.country_region = 'Asia'
  AND products.prod_category = 'Photo'
  GROUP BY ROLLUP(prod_name), times.calendar_quarter_number
  ORDER BY prod_name nulls last;
