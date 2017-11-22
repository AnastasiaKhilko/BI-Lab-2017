CREATE TABLE empt AS SELECT * FROM HR.employees CONNECT BY rownum < 500*107;

CREATE OR REPLACE PROCEDURE TASK2 (dem_id IN NUMBER)
IS
  pr NUMBER(3,2) := .03;
BEGIN
  UPDATE EMPT SET salary = salary + salary * pr WHERE department_id = dem_id;
  COMMIT;
END;
/

EXEC TASK2(90);

SELECT * FROM empt;


CREATE OR REPLACE FUNCTION TASK3 (abc IN NUMBER)
RETURN BOOLEAN 
IS
BEGIN
  dbms_lock.sleep(abc);
  IF dbms_random.value(0, 1) > 0.4 THEN
   RETURN TRUE;
  ELSE 
   RETURN FALSE;
  END IF;
END;
/


set serveroutput on;


begin
if task3(1) THEN
dbms_output.put_line('TRUE');
ELSE
dbms_output.put_line('FALSE');
END IF;
end;
/


CREATE OR REPLACE PROCEDURE TASK4 (dem_id IN NUMBER, rand  IN BOOLEAN)
IS
  pr NUMBER(3,2) := .05;
BEGIN
  IF rand THEN
  UPDATE EMPT SET salary = salary*pr WHERE department_id = dem_id;
  DBMS_OUTPUT.PUT_LINE('POVEZLO');
  ELSE
  DBMS_OUTPUT.PUT_LINE('NE POVEZLO');
  END IF;
  COMMIT;
END;
/


exec task4(1, task3(1));


CREATE OR REPLACE PROCEDURE TASK5 (dem_id IN NUMBER)
IS
  after_ex empt.salary%TYPE;
  after_in after_ex%TYPE;
  pr1 NUMBER(3,2) := .03;
  pr2 NUMBER(3,2) := .05;
  CURSOR ex_cur(dep_id NUMBER) IS
  SELECT * FROM empt
  WHERE department_id = dep_id FOR UPDATE;
  rec_ex_cur ex_cur%ROWTYPE;  
BEGIN
  FOR rec_in_cur IN (SELECT * FROM empt WHERE department_id = dem_id) LOOP
  IF rec_in_cur.salary > 10000 AND task3(1) THEN
    UPDATE EMPT SET salary = salary + salary*pr1  WHERE rec_in_cur.employee_id = employee_id;
    SELECT salary INTO after_in FROM empt WHERE rec_in_cur.employee_id = employee_id;
    DBMS_OUTPUT.PUT_LINE('POVEZLO (in)');
    DBMS_OUTPUT.PUT_LINE(rec_in_cur.salary || ' ' || after_in);
  ELSE
    DBMS_OUTPUT.PUT_LINE('NE POVEZLO (in)');
    END IF;
  END LOOP;
  
  OPEN ex_cur(dem_id);
  LOOP
  FETCH ex_cur INTO rec_ex_cur;
  EXIT WHEN ex_cur%NOTFOUND;
    IF rec_ex_cur.salary > 10000 AND task3(1) THEN
    UPDATE EMPT SET salary = salary + salary * pr2 WHERE rec_ex_cur.employee_id = employee_id;
    SELECT salary INTO after_ex FROM empt WHERE rec_ex_cur.employee_id = employee_id;
    DBMS_OUTPUT.PUT_LINE('POVEZLO (ex)');
    DBMS_OUTPUT.PUT_LINE(rec_ex_cur.salary || ' ' || after_ex);
  ELSE
    DBMS_OUTPUT.PUT_LINE('NE POVEZLO (ex)');
    END IF;
  END LOOP;
  CLOSE ex_cur;
  COMMIT;
END;
/

exec task5(90);


TRUNCATE TABLE empt;
INSERT INTO empt SELECT * FROM HR.EMPLOYEES;


