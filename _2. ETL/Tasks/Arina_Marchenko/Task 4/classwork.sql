CREATE TABLE emp AS
SELECT * FROM employees CONNECT BY level < 500;
CREATE OR REPLACE PROCEDURE raise3(
    department_p VARCHAR2)
IS
  salary NUMBER;
BEGIN
  UPDATE employees
  SET salary          =salary + salary*0.3
  WHERE department_id = department_p;
END;
/
EXECUTE raise3(20);
SELECT * FROM employees WHERE department_id = 20;
CREATE OR REPLACE FUNCTION raise_true(
    num IN NUMBER)
  RETURN VARCHAR2
IS
  raise_flag VARCHAR2(10);
BEGIN
  dbms_lock.sleep(1);
  IF ROUND(DBMS_RANDOM.value(low => 1, high => 20))>12 THEN
    raise_flag                                    :='FALSE';
  ELSE
    raise_flag:= 'TRUE';
  END IF;
  RETURN raise_flag;
END;
/
SELECT raise_true(5) FROM dual;
CREATE OR REPLACE PROCEDURE raise5(
    department_p NUMBER )
IS
  salary NUMBER;
BEGIN
  IF raise_true(4) <> 'true' THEN
    UPDATE employees
    SET salary          =salary + salary*0.05
    WHERE department_id = department_p;
  END IF;
END;
/
EXECUTE raise5(20);