show user;
/*task1*/
select count (*) from (select t1.*, rownum from HR.EMPLOYEES t1  cross join HR.EMPLOYEES t2 cross join HR.EMPLOYEES t3 where rownum <= 500*(select count (*) from HR.EMPLOYEEs));


/*task 2*/
CREATE or replace  PROCEDURE TASK2 (dep_id IN number, perc in number)
IS
BEGIN
    UPDATE HR.EMPLOYEES e SET e.salary = e.salary + e.salary*perc*0.01 WHERE dep_id = e.department_id;
    DBMS_OUTPUT.put_line('Update successed');
END;
/

/*task 3*/
--Create function which takes number and returns true in 40% cases and lasts not less than .1 second.
CREATE or replace function task3(var_num IN number) return boolean
IS
rand_val number(3); 
BEGIN
     rand_val:= trunc(dbms_random.value(1,10));
     dbms_lock.sleep(1);
     case 
     when  rand_val<=2 then return true ;
     else return false;
     end case;
 END;
/


set serveroutput on;
begin
 FOR cnt IN 0..10 LOOP
  case when task3(5) then DBMS_OUTPUT.put_line('true');
       else DBMS_OUTPUT.put_line('false');
  end case;
end loop;
end;


/*task4*/
CREATE or replace  PROCEDURE TASK4 (dep_id IN number, perc in number:=0)
IS
BEGIN
    --null;

    TASK2 (90, 3);
    DBMS_OUTPUT.put_line('Update1 successed');
    TASK2 (90, 5);
    DBMS_OUTPUT.put_line('Update2 successed. Do not forget to rollback!');

END;
/

/*return table: try*/
CREATE or replace  function TASK0 (dep_id IN number, perc in number:=0) RETURN number
IS
    TYPE emp_typ IS TABLE OF HR.EMPLOYEES%ROWTYPE INDEX BY PLS_INTEGER;
    modif_employees emp_typ;
BEGIN
    UPDATE HR.EMPLOYEES e SET e.salary = e.salary + e.salary*perc*0.01 WHERE dep_id = e.department_id;
    DBMS_OUTPUT.put_line('Update successed');
    SELECT * BULK COLLECT INTO modif_employees FROM HR.EMPLOYEES;
    --select * from modif_employees;
    return 1;
END;
/

declare
int_val table:=TASK0(90);
begin 
NULL;
end;
/




 /*CREATE OR REPLACE Function TotalIncome
   ( dep_id IN number ) return cursor
   IS
   total_val number(6);
   cursor c1 is (select * from HR.EMPLOYEES where DEPARTMENT_ID=dep_id);
 begin
   total_val := 0;

   FOR employee_rec in c1
   LOOP
      total_val := total_val + employee_rec.monthly_income;
   END LOOP;

   RETURN total_val;
 end;*/
 

set serveroutput on;

select * from HR.EMPLOYEES where DEPARTMENT_ID=90;
EXECUTE task4(90);
select * from HR.EMPLOYEES where DEPARTMENT_ID=90;
ROLLBACK;







