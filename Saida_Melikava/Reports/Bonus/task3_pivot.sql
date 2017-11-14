select * from
(
SELECT prod_name,COUNTRY_REGION,times.calendar_year,QUANTITY_SOLD
FROM sh.sales 
  LEFT JOIN sh.products
  ON sh.sales.prod_id=sh.products.prod_id
  LEFT JOIN sh.times
  ON sh.sales.time_id=sh.times.time_id
  LEFT JOIN sh.customers
  ON sh.sales.cust_id=sh.customers.cust_id
  LEFT JOIN 
  sh.countries
  ON sh.customers.country_id   =sh.countries.country_id
  )
PIVOT(SUM(QUANTITY_SOLD)
for (country_region,calendar_year) in (('Europe','2000')as Europe_2000, ('Asia','2000')as Asia_2000,
('Europe',2001)as Europe_2001, ('Asia',2001)as Asia_2001
)
)
;

