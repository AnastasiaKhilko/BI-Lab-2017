CREATE TABLE foreall_table AS
SELECT * FROM employees;
/
DECLARE
  CURSOR c_data
  IS
    SELECT department_id FROM departments;
type t__data
IS
  TABLE OF NUMBER; --NESTED TABLE
  t_data t__data;
BEGIN
  OPEN c_data;
  LOOP
    FETCH c_data bulk collect INTO t_data limit 10000;
    EXIT
  WHEN t_data.count = 0;
    FORALL i IN t_data.FIRST..t_data.LAST
    DELETE FROM foreall_table WHERE department_id = t_data(i);
    COMMIT;
  END LOOP;
  CLOSE c_data;
END;
/
SELECT COUNT(*) FROM foreall_table;
SELECT * FROM foreall_table;