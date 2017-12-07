PROCEDURE insert_table_payment_methods
IS
  CURSOR my_cursor
  IS
    SELECT payment_method_id,
      payment_method_name AS payment_method,
      start_dt,
      end_dt,
      is_active
    FROM wrk_payment_methods
    WHERE payment_method_name IS NOT NULL
    AND start_dt              IS NOT NULL;
  pm_my_cursor cls_payment_methods%rowtype;
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_payment_methods';
  OPEN my_cursor;
  LOOP
    FETCH my_cursor INTO pm_my_cursor;
    IF my_cursor%found THEN
      INSERT
      INTO cls_payment_methods
        (
          payment_method_id,
          payment_method,
          start_dt,
          end_dt,
          is_active
        )
        VALUES
        (
          pm_emp_cursor.payment_method_id,
          pm_emp_cursor.payment_method,
          pm_emp_cursor.start_dt,
          pm_emp_cursor.end_dt,
          pm_emp_cursor.is_active
        ) ;
    END IF;
    EXIT
  WHEN my_cursor%notfound;
  END LOOP;
  COMMIT;
  CLOSE my_cursor;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END insert_cls_payment_methods;
