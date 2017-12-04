--CLS_DELIVERY_METHODS_INSERT
TRUNCATE TABLE CLS_DELIVERY_METHODS;
INSERT INTO cls_delivery_methods (
                                   delivery_method_id,
                                   delivery_method,
                                   start_dt,
                                   end_dt,
                                   is_active
                                   )
SELECT SUBSTR(delivery_method_name,1,4) AS delivery_method_id,
       delivery_method_name AS delivery_method,
       start_dt,
       end_dt,
       is_active
  FROM wrk_delivery_methods;

  COMMIT;