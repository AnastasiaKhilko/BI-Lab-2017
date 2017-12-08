CREATE TABLE foreall_table AS
SELECT * FROM cls_customers;
/
DECLARE
  CURSOR cur
  IS
    SELECT address_id FROM bl_3nf.ce_addresses;
type t__data
IS
  TABLE OF NUMBER; --NESTED TABLE
  t_data t__data;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FORALL i IN t_data.FIRST..t_data.LAST
    DELETE FROM foreall_table WHERE address_id = t_data(i);
    COMMIT;
  END LOOP;
  CLOSE cur;
END;
/
SELECT COUNT(*) FROM foreall_table;
SELECT * FROM foreall_table;