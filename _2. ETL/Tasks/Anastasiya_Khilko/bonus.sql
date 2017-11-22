--made by Vitaliya Adamchuk and Anastasiya Khilko
-- 1
create table emp as SELECT * FROM employees
connect by level < 500;
--2
create or replace procedure raise3 (department_p varchar2) is
 salary number;
begin
update employees
set salary =salary + salary*0.03
where department_id = department_p;
end;
/
-- run 2
execute raise3(20);
-- check 2
select * from employees
where department_id = 20;

-- 3

create or replace function raise_true(num in NUMBER)
return varchar2 
IS raise_flag varchar2(10);
begin
dbms_lock.sleep(1); 
if 
round(DBMS_RANDOM.value(low => 1, high => 20))>12 
then  raise_flag:='FALSE';
else raise_flag:= 'TRUE';
end if;
return raise_flag;
end;
/
-- run 3
select raise_true(5) from dual;

--4
create or replace procedure raise5(department_p number )
is salary number;
begin
if raise_true(4) <> 'true' then
update employees
set salary =salary + salary*0.05
where department_id = department_p;
end if;
end;
/
--run4
execute raise5(20);
-- check 4
select * from employees
where department_id = 20;


