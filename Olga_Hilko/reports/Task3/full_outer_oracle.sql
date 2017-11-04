EXPLAIN PLAN FOR 
SELECT 
/*+use_hash(t e) LEADING(t e)*/ * 
FROM    t5 t full outer join emplRand e
on e.depno = t.valRand;
SELECT    *   FROM table(DBMS_XPLAN.DISPLAY); 