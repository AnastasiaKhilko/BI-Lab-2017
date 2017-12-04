--CLS_CUSTOMERS_INSERT
TRUNCATE TABLE cls_customers;
INSERT /*+ APPEND */ INTO cls_customers (
                              customer_id,
                              first_name,
                              last_name,
                              gender,
                              age,
                              email,
                              phone,
                              address,
                              city_id,
                              start_dt,
                              end_dt,
                              is_active
                            )
SELECT   cc_number as customer_id,
         first_name,
         last_name,
         gender,
         age,
         email,
         phone,
         address,
         wct.city_id,
         start_dt,
         end_dt,
         is_active
  FROM wrk_customers wst inner join wrk_cities wct on wst.city = wct.city_name;

  COMMIT;