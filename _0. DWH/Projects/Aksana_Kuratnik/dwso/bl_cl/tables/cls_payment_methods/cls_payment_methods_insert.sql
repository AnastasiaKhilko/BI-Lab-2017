--CLS_PAYMENT_METHODS_INSERT
TRUNCATE TABLE CLS_PAYMENT_METHODS;
INSERT INTO cls_payment_methods (
                                   payment_method_id,
                                   payment_method,
                                   start_dt,
                                   end_dt,
                                   is_active
                                   )
SELECT SUBSTR(payment_method_name,1,4) AS payment_method_id,
       payment_method_name AS payment_method,
       start_dt,
       end_dt,
       is_active
  FROM wrk_payment_methods;

  COMMIT;