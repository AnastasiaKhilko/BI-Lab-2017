--EMP
CREATE TABLE emp (id_c int, deptno int, rand_val int, ename VARCHAR2(50));

declare
ab NUMBER;
cnt int := 0;
begin
for cnt IN 1..30000 LOOP
ab := trunc(dbms_random.value(1,14));
--select (select trunc(dbms_random.value(1,14)) from dual) into ab from dual;
INSERT INTO emp (id_c,deptno, rand_val, ename) 
 SELECT cnt, trunc(dbms_random.value(1,7))*10, trunc(dbms_random.value(1,100000)), (select ename from(select ename, rank() over(order by ename) as ranme from scott.emp) where ranme = ab)  FROM DUAL;
 END LOOP;
end;
/


--DEPT
CREATE TABLE dept AS (SELECT * FROM scott.dept);
