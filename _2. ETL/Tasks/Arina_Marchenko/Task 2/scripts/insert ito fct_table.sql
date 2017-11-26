BEGIN
  FOR i IN 1..500
  LOOP
    dbms_random.seed
    (
      i * 3
    )
    ;
  INSERT INTO fct_table
  (      Event_dt,
         cust_id,
         country_id,
         prod_id,
         channel_id,
         total_price,
         amount  
         )
  SELECT TRUNC ( SYSDATE - DBMS_RANDOM.VALUE ( 1, 1700 ) ) AS EVENT_DT ,
      ROUND (DBMS_RANDOM.VALUE (1,
      (SELECT MAX(CUST_ID)FROM DIM_CUST
      ))) AS CUST_ID ,
      ROUND ( DBMS_RANDOM.VALUE (1,
      (SELECT MAX(COUNTRY_ID)FROM DIM_COUNTRIES
      ))) AS COUNTRY_ID ,
      ROUND ( DBMS_RANDOM.VALUE (1,
      ( SELECT MAX(PROD_ID) FROM DIM_PROD
      )) ) AS PROD_ID ,
      ROUND ( DBMS_RANDOM.VALUE (1,
      ( SELECT MAX(CHANNEL_ID) FROM DIM_CHANNELS
      )) ) AS CHANNEL_ID ,
      ROUND ( DBMS_RANDOM.VALUE (10, 500) ) AS total_price ,
      ROUND ( DBMS_RANDOM.VALUE (1, 20) )   AS AMOUNT 
    FROM dual
      CONNECT BY level <= 10000;
  END LOOP;
END;
/