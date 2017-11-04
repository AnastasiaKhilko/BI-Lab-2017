execute dbms_stats.gather_schema_stats (ownname =>'LOLASOVA',cascade => TRUE);
EXPLAIN PLAN FOR 
SELECT 
/*+use_merge(t e) LEADING(t e) index(IDX_T5_VALRAND)*/ * 
FROM    t5 t left join emplRand e
on e.depno=t.valRand  --e.depno(+)=t.valRand
UNION all
SELECT
/*+index(EMPLRAND IDX_T5_VALRAND) use_merge(e t) LEADING(e t) */   null, null, e.*
FROM    t5 t right join emplRand e
on e.depno = t.valRand
where t.valRand is null
;


SELECT    *   FROM table(DBMS_XPLAN.DISPLAY); 
--select * from scott.emp e;

--t.valRand, e.DEPNO