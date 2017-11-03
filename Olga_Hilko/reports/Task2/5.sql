--2.4.1.	Step 1
  CREATE TABLE employees AS
    SELECT *
      FROM scott.emp;
--2.4.2.	Step 2:
   CREATE INDEX idx_emp01 ON employees
      ( empno, ename, job );
--2.4.3.	Step 3
--Collect trace and statistic for the queries below:
SELECT 
/*+INDEX_SS(emp idx_emp01)*/ 
emp.* FROM employees emp where ename = 'SCOTT';

SELECT 
/*+FULL*/ 
emp.* FROM employees emp WHERE ename = 'SCOTT';


SELECT blocks FROM user_segments WHERE segment_name = upper('employees');

SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct
FROM employees ;


