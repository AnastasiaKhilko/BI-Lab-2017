EXPLAIN PLAN FOR 
SELECT  /*+use_merge(d e)*/ *
FROM scott.emp e, scott.dept d
WHERE 
e.deptno = d.deptno
--;
AND 
d.deptno = 10;

SELECT    *
  FROM table(DBMS_XPLAN.DISPLAY); 


select * from scott.emp e;
--, scott.dept d

SELECT DISTINCT OWNER, OBJECT_NAME 
  FROM DBA_OBJECTS
 WHERE OBJECT_TYPE = 'TABLE'
   AND OWNER = upper('scott');
   
   
select
   table_name,
   num_rows counter
from
   dba_tables
where
   owner = upper('scott')
order by
   table_name;
   
   
   
execute dbms_stats.gather_schema_stats (ownname =>'LOLASOVA',cascade => TRUE);
CREATE TABLE T5 AS(SELECT ROWNUM id, trunc(DBMS_RANDOM.VALUE(1, 10000),0)  valRand FROM DUAL CONNECT BY ROWNUM<10000);  

select * from t5;
drop table t5;