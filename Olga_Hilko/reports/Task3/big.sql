--execute dbms_stats.gather_schema_stats (ownname =>'LOLASOVA',cascade => TRUE);
--create index()
EXPLAIN PLAN FOR 
/*SELECT --t.valRand, e.DEPNO
--+use_nl(t) 
* --LEADING(e)
 -- e.ename, d.depno --d.dname
FROM    t5 t, emplRand e where e.depno(+) = t.valRand;*/
select --+use_hash(e t) LEADING(e t)
* 
FROM    t5 t left  join emplRand e
on  e.depno = t.valRand;

SELECT    *   FROM table(DBMS_XPLAN.DISPLAY); 
--select * from scott.emp e;

