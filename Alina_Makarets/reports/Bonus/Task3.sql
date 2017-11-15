SELECT * 
FROM
(SELECT COUNTRIES.COUNTRY_REGION,
        PRODUCTS.PROD_CATEGORY,
        AMOUNT_SOLD
       FROM PRODUCTS,
             TIMES,
             SALES,
             COUNTRIES,
             CUSTOMERS
        WHERE SALES.TIME_ID=TIMES.TIME_ID and
              SALES.CUST_ID=CUSTOMERS.CUST_ID and
              SALES.PROD_ID=PRODUCTS.PROD_ID and 
              CUSTOMERS.COUNTRY_ID=COUNTRIES.COUNTRY_ID)
            PIVOT (SUM(AMOUNT_SOLD) AS SUMS
                    FOR (PROD_CATEGORY) IN (('Electronics') AS Electronics,
                                                   ('Hardware') AS Hardware,
                                                   ('Peripherals and Accessories') AS Peripherals_and_Accessories,
                                                   ('Photo') AS Photo,
                                                   ('Software/Other') AS Software_Other
                                                   ));     
                                                   
                                                   
 