INSERT
INTO bl_dm.fct_sales1
  (
    event_dt,
    fct_customer_id,
    fct_employee_id,
    fct_store_id,
    fct_store_dist_id,
    fct_product_id,
    fct_check_id,
    fct_payment_id,
    fct_quantity,
    fct_discount,
    fct_unit_price_byn,
    fct_byn_usd
  )
SELECT to_date(to_date('01-01-2005','dd-MM-yyyy')+dbms_random.value(1,3500),'dd-MM-yyyy')     AS event_dt,
  pckg_insert_fact.randomize_max('bl_3nf.ce_customers', 'customer_id') AS customer_id,
  pckg_insert_fact.randomize_max('bl_3nf.ce_employees', 'employee_id') AS employee_id,
  pckg_insert_fact.randomize_max('bl_3nf.ce_stores', 'store_id')       AS store_id,
  '1',
  pckg_insert_fact.randomize_max('bl_3nf.ce_catalog', 'prod_id')       AS product_id,
  ABS(ROUND(dbms_random.normal()*400000))                              AS check_id,
  pckg_insert_fact.randomize(1,5,8,11,12)                              AS paym_id ,
  pckg_insert_fact.randomize(1,4,10,20,50)                             AS quantity,
  ROUND((pckg_insert_fact.randomize(1,10,25,35,50))/100,2)             AS disc,
  pckg_insert_fact.randomize(5,20,35,45,100)                           AS price,
  ROUND((pckg_insert_fact.randomize(160,175,180,190,200))/100,2)       AS byn_usd
FROM
  ( SELECT level n FROM dual CONNECT BY level <= 1000
  );