------------event date------------
SELECT TO_DATE( 
            TRUNC
            ((SELECT MIN(Date_id) FROM DIM_TIME_DAY)+DBMS_RANDOM.VALUE(1,2554)
                
                ))  as Event_date
                FROM DUAL;
------------product_id------------
SELECT ROUND 
    ( dbms_random.value 
        ( 0.51, 
          ( SELECT COUNT ( * ) FROM DIM_products ) + .49 ) 
          ) AS product_id
FROM dual;
------------customer_id------------
SELECT ROUND 
    ( dbms_random.value 
        ( 0.51, 
          ( SELECT COUNT ( * ) FROM DIM_customers ) + .49 ) 
          ) AS customer_id
FROM dual;
------------store_id------------
SELECT ROUND 
    ( dbms_random.value 
        ( 0.51, 
          ( SELECT COUNT ( * ) FROM DIM_stores ) + .49 ) 
          ) AS store_id
FROM dual;
------------amount------------
SELECT ROUND 
    ( dbms_random.value 
        ( 0.51, 
          5.49 ) 
          ) AS amount
FROM dual;
------------amount------------

