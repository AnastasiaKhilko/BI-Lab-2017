execute dbms_stats.gather_schema_stats (ownname =>'SCOTT',cascade => TRUE);
EXPLAIN PLAN FOR 
SELECT  /*+use_merge(d e) LEADING(d) */
* -- e.ename, d.depno --d.dname
--LEADING(e d)
FROM scott.emp e, scott.dept d
WHERE 
e.deptno = d.deptno;
--AND d.deptno = 10;

SELECT    *   FROM table(DBMS_XPLAN.DISPLAY); 