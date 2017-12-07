PROCEDURE insert_table_payment_methods
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_payment_methods');
  INSERT
  INTO cls_payment_methods
    (
      payment_method_id,
      payment_method,
      start_dt,
      end_dt,
      is_active
    )
  SELECT SUBSTR(payment_method,1,5)
    || '-'
    || TRUNC(dbms_random.value(1,1000000)) AS payment_method_id,
    payment_method_name                    AS payment_method,
    start_dt,
    end_dt,
    is_active
  FROM wrk_payment_methods;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_table_payment_methods;
