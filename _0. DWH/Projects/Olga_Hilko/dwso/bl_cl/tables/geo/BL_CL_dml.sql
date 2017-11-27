insert into CL_Country (id_country,country_name,country_code,id_parent,date_update) values (1,'Республика Беларусь','BY',null,sysdate);
--commit;
insert into CL_Region (
select distinct t1, obl,0,1 as id_country, sysdate from wrk_GEO s where obl is not null); --6 области (РБ)
rollback;

insert into CL_District
select distinct t1*1000+t2 child_id, raion  || ' район' child_name, 0, t1, 
(select max(datav) from (select w.*, DENSE_RANK() OVER (partition by w.t1,w.t2 ORDER BY w.datav DESC) r from wrk_GEO w)  where r=1) as datav
from wrk_GEO s  where raion is not null;  --122 района (обл. подчинение)


insert into CL_Sovet
/*select distinct t1*1000000+t2*1000+t3 id,  sovet, t1*1000+t2 parent_id, 
(select max(sub.datav) from wrk_GEO sub where w.t1*1000+w.t2=sub.t1*1000+sub.t2) date_update  
from wrk_GEO w where  sovet is not null and raion is not null ; -- 1553 сельских советы (районного подчинения ) /1335 без повторений
*/
select distinct t1*1000000+t2*1000+t3 id,  sovet,0, d.ID_DISTRICT,
(select max(sub.datav) from wrk_GEO sub where w.t1*1000+w.t2=sub.t1*1000+sub.t2) date_update  
from wrk_GEO w inner join CL_District d 
on (w.RAION|| ' район')=d.DISTRICT_NAME 
where  sovet is not null and raion is not null ; -- 1553 сельских советы (районного подчинения ) /1335 без повторений

 --select count(*) from(
 insert into CL_Location
 select w.soato, w.name,s.ID_SOVET , datav
 from wrk_GEO w inner join CL_Sovet s on s.sovet_name = w.sovet 
 and s.ID_SOVET=(w.t1*1000000+w.t2*1000+w.t3) and w.name is not null 
-- )
 ; --order by 1,2,3-- 27189  нас. пункты (сель/сов)  /23403
  
 /* select * from (select w.*, DENSE_RANK() OVER (PARTITION BY id_location ORDER BY location_name DESC) AS ra from CL_Location w )
  where ra>1
  ;
  --where ID_SOVET=755;
  select * from CL_Location l inner join CL_Location l2 
  on l.ID_LOCATION=l2.ID_LOCATION and l.LOCATION_NAME!=l2.LOCATION_NAME;
 
  select * from CL_Sovet;*/
  
 
--t1, obl,0,1 as id_country, sysdate from wrk_GEO  
/*select oblast.t1 ,oblast.obl, 1, city.name from
(select distinct t1, obl from wrk_GEO s where obl is not null order by obl --6 областей (РБ)
) oblast
inner join 
(select distinct t1, name from wrk_GEO s where obl is null and name is not null order by name --6 областных города (РБ)
) city on oblast.t1=city.t1
union 
select t1,'МИНСКАЯ ОБЛАСТЬ',  name  from wrk_GEO s where name='Минск' ;*/

insert   into CL_REGION
select soato, name,1,1 id_county,datav from wrk_GEO s where obl is null and name is not null ; --6 областных города (РБ)
commit;

--obl podchinenie - goroda
-- если город областной - id=soato
insert into CL_District
select soato child_id,  name, 1, t1 par_id, datav -- d.DISTRICT_NAME 
from CL_District d 
inner join  wrk_GEO s on (s.t1*1000+s.t2)=d.ID_DISTRICT
where
raion is null and obl is not null and 
t3 in (501,0,551,555)
;
--районное подчинение id=soato
insert into CL_Sovet
select soato child_id,  name, 1, 
(select d.ID_DISTRICT from CL_District  d where d.district_name = g.RAION || ' район') par_id, 
datav -- d.DISTRICT_NAME 
from wrk_GEO g 
--inner join CL_SOVET s  on (g.t1*1000000+g.t2*1000+g.t3)=s.ID_SOVET
where
sovet is null and raion is not null
--t3 in (501,0,551,555)
;
--137 / 110 / 6

/*select  CL_SOVET.*,CL_DISTRICT.DISTRICT_NAME  from CL_SOVET   INNER JOIN  CL_DISTRICT ON CL_DISTRICT.ID_DISTRICT=CL_SOVET.ID_DISTRICT
order by CL_DISTRICT.ID_DISTRICT, CL_SOVET.IS_TOWN DESC;
select  * from CL_REGION;
select  * from CL_DISTRICT;
select  * from CL_SOVET;



select t1*1000+t2, RAION from wrk_GEO
where (t1*1000+t2) not in (select id_district from CL_District) and
raion is null or obl is null
group by t1*1000+t2, RAION ;*/

