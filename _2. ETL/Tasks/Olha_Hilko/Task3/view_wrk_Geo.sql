create or replace view view_wrk_Geo as select distinct 'OBL'||t1 par_id, 'RAI'||t1||t2 child_id, 
obl par_name, raion  || ' район' child_name  from wrk_GEO s  where raion is not null  --122 района (обл. подчинение)
union all
select distinct 'OBL'||t1 par_id, 'TOWN'||t2||t3 child_id,   obl,  name from wrk_GEO s  
where raion is null and obl is not null                                              --130 города (обл. подчинение)
union all
select distinct 'BY','OBL'||t1, 'Беларусь' , obl from wrk_GEO s where obl is not null --6 области (РБ)
union all
select distinct 'BY', 'CITY'||t1, 'Беларусь', name from wrk_GEO s where obl is null --6 областных города (РБ) --'CITY'||t1
union all
select distinct 'RAI'||t1||t2 , to_char(soato), raion ||' район',  name
 from wrk_GEO where  sovet is null and raion is not null                   -- 213 нас. пункты (районного подчинения )
 union all
 select  'SOV'||t1||t2||t3, to_char(soato), sovet ||' совет',  name
 from wrk_GEO where  sovet is not null and raion is not null --order by 1,2,3-- 27189  нас. пункты (сель/сов) 
  union all
 select distinct 'RAI'||t1||t2 child_id,  'SOV'||t1||t2||t3,  
raion, sovet from wrk_GEO  where  sovet is not null and raion is not null ; -- 1553 сельских советы (районного подчинения )
--union all select '-99','BY', 'Беларусь','Беларусь' from dual;
--order by raion;                                                            
select * from view_wrk_Geo;


select * from view_wrk_Geo t1 inner join view_wrk_Geo t2
on t1.par_id = t2.child_id;
