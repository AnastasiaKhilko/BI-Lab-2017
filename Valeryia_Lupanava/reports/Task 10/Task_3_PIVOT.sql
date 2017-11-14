SELECT *
FROM
  (SELECT CHANNEL_ID, PROD_ID, AMOUNT_SOLD FROM SALES
  )PIVOT (SUM(AMOUNT_SOLD) 
           AS AMOUNT_SOLD 
           FOR (PROD_ID) 
           IN ('13' AS the_13_th, '14' AS the_14_th, '15' AS the_15_th, '16' AS the_16_th));