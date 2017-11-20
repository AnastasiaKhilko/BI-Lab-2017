create table t as 
select 1 q,'one' w from dual
union all
select 2,'two' from dual;

select * from t;

update t set w='two' where q=2;

update t set w='one' where q=1;

