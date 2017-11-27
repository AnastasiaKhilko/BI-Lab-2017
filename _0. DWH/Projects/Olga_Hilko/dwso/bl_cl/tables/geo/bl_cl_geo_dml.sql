insert into CL_Country (id_country,country_name,country_code,id_parent,date_update) values (1,'Республика Беларусь','BY',null,sysdate);

insert into CL_Region (
select distinct t1, obl,1 as id_country, sysdate from wrk_GEO s where obl is not null); --6 области (РБ)
--rollback;

insert into CL_District
select distinct --t1*1000+t2 child_id, 
gni,
raion  || ' район' child_name, t1, 
(select max(datav) from (select w.*, DENSE_RANK() OVER (partition by w.t1,w.t2 ORDER BY w.datav DESC) r from wrk_GEO w)  where r=1) as datav
from wrk_GEO s  where raion is not null;  --122 района (обл. подчинение)

/*insert into CL_Location
select distinct t1*1000000+t2*1000+t3 id,  sovet,1, d.ID_DISTRICT,
(select max(sub.datav) from wrk_GEO sub where w.t1*1000+w.t2=sub.t1*1000+sub.t2) date_update  
from wrk_GEO w inner join CL_District d 
on (w.RAION|| ' район')=d.DISTRICT_NAME 
where  sovet is not null and raion is not null ; -- 1553 сельских советы (районного подчинения ) /1335 без повторений
*/
-- rollback;
 truncate table CL_Location;
 insert into CL_Location                                --кроме городов областного подчинения 23,648 /23651 - c t3=0
 select w.soato, w.name, 0,gni,                         --было: 27189  нас. пункты (сель/сов)  /23403
 --s.ID_SOVET , 
 datav
 from wrk_GEO w 
 left join CL_District s on s.id_District = w.gni 
 --and s.ID_SOVET=(w.t1*1000000+w.t2*1000+w.t3) and 
 where w.name is not null and s.id_District is not null and t3!=0;

 
/* select oblast.t1 ,oblast.obl, city.name from
(select distinct t1, obl from wrk_GEO s where obl is not null order by obl --6 областей (РБ)
) oblast
inner join 
(select distinct t1, name from wrk_GEO s where obl is null and name is not null order by name --6 областных города (РБ)
) city on oblast.t1=city.t1
union 
select t1,'МИНСКАЯ ОБЛАСТЬ',  name  from wrk_GEO s where name='Минск' ;*/


insert into CL_District 
select -(cast (oblast.t1 as number)) id_fake ,oblast.obl,cast (oblast.t1 as number) id_obl, sysdate from
(select distinct t1, obl from wrk_GEO s where obl is not null order by obl --6 областей (РБ)
) oblast;
 select * from CL_region;
 
 
 insert into CL_Location   
 select w.soato, w.name,0, -t1 , datav                         --7 городов областного полчинения
 from wrk_GEO w 
 where w.name is not null and obl is not null and t3=0  ;
 
 
--select id_location, location_name, is_sovet, id_parent, date_update from CL_Location;

insert into CL_Location   
select w.soato ,w.name,0, -t1 , datav  
from wrk_GEO w where  obl is null and name is not null and name !='Минск' --5 областных города (РБ)
--insert into CL_Location 
union ALL
select w.soato ,w.name,0,-6, datav
from wrk_GEO w 
where name='Минск' ;
 

