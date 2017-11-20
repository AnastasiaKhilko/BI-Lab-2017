BEGIN
  FOR i IN 1..50
  LOOP
    dbms_random.seed
    (
      i * 5
    )
    ;
  INSERT INTO fct_table
  SELECT  fct.Event_date,
         fct.product_id,
         fct.customer_id,
         fct.store_id,
         fct.amount*prd.list_price AS total_price,
         fct.amount  
  FROM
      (SELECT TO_DATE( ------------event date------------
              TRUNC
              (
                  (SELECT MIN(Date_id) FROM DIM_TIME_DAY)+DBMS_RANDOM.VALUE(1,2554)
                  )) as Event_date,
              ROUND ------------product_id------------      
               (DBMS_RANDOM.VALUE( 
                  ( SELECT MIN(PRODUCT_ID) FROM dim_products),
                    (SELECT MAX(PRODUCT_ID) FROM dim_products) 
                    )) AS product_id,
               ROUND ------------customer_id------------       
              (DBMS_RANDOM.VALUE 
                  ( (SELECT MIN(CUSTOMER_ID) FROM dim_customers),
                    (SELECT MAX(CUSTOMER_ID) FROM dim_customers) 
                    )) AS customer_id,
               ROUND  ------------store_id------------ 
              (DBMS_RANDOM.VALUE 
                  ( (SELECT MIN(STORE_ID) FROM dim_stores), 
                    (SELECT MAX(STORE_ID) FROM dim_stores) 
                    )) AS store_id,
               ROUND   ------------amount------------  
              (DBMS_RANDOM.VALUE 
                (1,5) 
                  ) AS amount
     FROM DUAL
      CONNECT BY level <= 100000
     ) fct,
      (SELECT product_id,
              list_price 
      FROM dim_products
      ) prd,
      (SELECT customer_id
      FROM dim_customers) cust,
      (SELECT store_id
      FROM dim_stores) str,
      (SELECT date_id
      FROM dim_time_day) dtd
      WHERE fct.product_id=prd.product_id
      AND fct.customer_id=cust.customer_id
      AND fct.store_id=str.store_id
      AND to_date(fct.event_date,'dd-mm-yyyy')=to_date(dtd.date_id,'dd-mm-yyyy');
  END LOOP;
END;
