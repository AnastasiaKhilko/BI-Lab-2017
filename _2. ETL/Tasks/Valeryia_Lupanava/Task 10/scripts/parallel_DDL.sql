CREATE TABLE employees
PARALLEL 5
AS
SELECT position_name, count(position_name) AS amount
FROM bl_dm.dim_employees_scd
GROUP BY position_name;

EXPLAIN PLAN FOR
SELECT position_name, count(position_name) AS amount
FROM employees 
WHERE position_name = 'financial advisor'
GROUP BY position_name;
  
SELECT * FROM TABLE (dbms_xplan.display);