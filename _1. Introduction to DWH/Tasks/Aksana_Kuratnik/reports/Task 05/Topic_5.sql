------------------------------------------------------
--Nested Loop Join
EXPLAIN PLAN FOR
SELECT /*USE_NL(e, jh)*/ *
FROM HR.DEPARTMENTS d,
  HR.JOB_HISTORY jh
WHERE d.DEPARTMENT_ID = jh.DEPARTMENT_ID
AND d.DEPARTMENT_ID   = 50 ;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--SORT_MERGE JOIN
EXPLAIN PLAN FOR
SELECT /*+USE_MERGE(d e)*/e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, e.JOB_ID, e.SALARY
from HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
AND e.SALARY > 12000;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--HASH JOIN
EXPLAIN PLAN FOR
SELECT /* +USE_HASH (d e) */d.DEPARTMENT_NAME, e.FIRST_NAME, e.LAST_NAME, e.SALARY
from HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE  e.EMPLOYEE_ID = d.MANAGER_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--Cartesian Join
EXPLAIN PLAN FOR
SELECT /*+LEADING (d e) */* 
FROM  HR.DEPARTMENTS d, HR.EMPLOYEES e;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--LEFT JOIN
EXPLAIN PLAN FOR
SELECT * 
FROM  HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE d.DEPARTMENT_ID(+) = e.DEPARTMENT_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT * 
FROM HR.EMPLOYEES e LEFT JOIN HR.DEPARTMENTS d 
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--RIGHT JOIN
EXPLAIN PLAN FOR
SELECT * 
FROM  HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID(+);

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT * 
FROM HR.EMPLOYEES e RIGHT JOIN HR.DEPARTMENTS d 
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

------------------------------------------------------
--FULL JOIN
--EXPLAIN PLAN FOR
SELECT * 
FROM  HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID(+)
UNION
SELECT * 
FROM  HR.DEPARTMENTS d, HR.EMPLOYEES e
WHERE d.DEPARTMENT_ID(+) = e.DEPARTMENT_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);

--EXPLAIN PLAN FOR
SELECT * 
FROM HR.DEPARTMENTS d  FULL OUTER JOIN HR.EMPLOYEES e 
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID;

SELECT* FROM TABLE (DBMS_XPLAN.DISPLAY);


