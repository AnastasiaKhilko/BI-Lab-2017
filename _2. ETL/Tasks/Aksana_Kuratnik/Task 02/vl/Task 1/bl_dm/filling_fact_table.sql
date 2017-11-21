BEGIN

  FOR i IN 1..20
  LOOP
    dbms_random.seed
    (
      i * 5
    )
    ;

     INSERT INTO fct_retail_sales_dd
     SELECT
       TRUNC(dbms_random.value(100000000000, 9999999999999)) as receipt_id
     , TRUNC ( (sysdate + 7) + dbms_random.value ( 1, 1000 ) ) AS event_dt
     , ROUND ( dbms_random.value ( ( SELECT MIN ( product_surr_id ) FROM dim_products_scd), ( SELECT MAX ( product_surr_id ) FROM dim_products_scd) ) ) AS product_surr_id
     , ROUND ( dbms_random.value ( ( SELECT MIN ( employee_surr_id ) FROM dim_employees_scd), ( SELECT MAX ( employee_surr_id ) FROM dim_employees_scd) ) ) AS employee_surr_id
     , ROUND ( dbms_random.value ( ( SELECT MIN ( customer_surr_id ) FROM dim_customers_scd), ( SELECT MAX ( customer_surr_id ) FROM dim_customers_scd) ) ) AS customer_surr_id
     , ROUND ( dbms_random.value ( ( SELECT MIN ( store_surr_id ) FROM dim_stores), ( SELECT MAX ( store_surr_id ) FROM dim_stores) ) ) as store_id
     , CEIL(dbms_random.value(10000, 99999)) AS tot_sale_sum
     , CEIL(dbms_random.value(10000, 99999)) AS tot_sale_amount
     , sysdate AS insert_dt
     , sysdate AS update_dt
        FROM dual
        CONNECT BY level <= 100000;

  END LOOP;

END;
