CREATE TABLE emplRand (id int ,depno int, randVal int, ename VARCHAR2(50));

declare
ab NUMBER;
cnt int := 0;
begin
for cnt IN 1..10000 LOOP
ab := trunc(dbms_random.value(1,14));
INSERT INTO emplRand(id, depno, randVal, ename) 
 SELECT cnt,trunc(dbms_random.value(1,4))*10, trunc(dbms_random.value(1,10000)), 
 (select ename from(select ename, rank() over(order by ename) as ranme from scott.emp) where ranme = ab)  FROM DUAL;
 END LOOP;
end;




create index idx_t5_valRand on t5 (valRand) ;
create index idx_emplRand_depno on emplRand (depno) ;


execute dbms_stats.gather_schema_stats (ownname =>'LOLASOVA',cascade => TRUE);