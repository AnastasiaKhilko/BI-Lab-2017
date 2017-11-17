execute dbms_stats.gather_schema_stats (ownname =>'SCOTT',cascade => TRUE);
EXPLAIN PLAN FOR 
SELECT  /*+use_hash(e t5) LEADING(e) */
* -- e.ename, d.depno --d.dname
--LEADING(e d)
FROM emplRand e --scott.dept d
WHERE 
e.ID in (select id from t5 where valrand<5555 and valrand > 5500) ;
--AND d.deptno = 10;

SELECT    *   FROM table(DBMS_XPLAN.DISPLAY); 