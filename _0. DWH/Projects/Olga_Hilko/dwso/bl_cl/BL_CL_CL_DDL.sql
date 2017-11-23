--select * from SRC_GEO;
show user;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Location', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Sovet', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_District', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Region', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Country', 'TABLE');


create table CL_Country
(id_country NUMBER(10) Primary key,
country_name varchar(100) not null,
country_code varchar(100) not null,
id_parent NUMBER(10),
date_update date not null
);

select * from CL_Country;
create table CL_Region
(id_region NUMBER(10) Primary key,
region_name varchar(100) not null,
--region_center varchar(100) not null,
id_country NUMBER(10) not null,
date_update date not null,
constraint FK_Region_Country FOREIGN KEY (id_country) REFERENCES CL_Country (id_country)  
);

insert into CL_Country (id_country,country_name,country_code,id_parent,date_update) values (1,'Республика Беларусь','BY',null,sysdate);
--commit;
insert into CL_Region (
select distinct t1, obl,1 as id_country, sysdate from wrk_GEO s where obl is not null); --6 области (РБ)
--select * from wrk_GEO;


create table CL_District
(id_district NUMBER(10) Primary key,
district_name varchar(100) not null,
id_region NUMBER(10)  not null,
date_update date not null,
constraint FK_District_Region FOREIGN KEY (id_region) REFERENCES CL_Region (id_region)  
);
--
select datav from (select w.*, DENSE_RANK() OVER (partition by w.t1,w.t2 ORDER BY w.datav DESC) r from wrk_GEO w) where r=1;
select * from CL_District;

insert into CL_District
select distinct t1*1000+t2 child_id, raion  || ' район' child_name, t1, 
(select max(datav) from (select w.*, DENSE_RANK() OVER (partition by w.t1,w.t2 ORDER BY w.datav DESC) r from wrk_GEO w)  where r=1) as datav
from wrk_GEO s  where raion is not null;  --122 района (обл. подчинение)


create table CL_Sovet
(id_sovet NUMBER(10) Primary key,
sovet_name varchar(100) not null,
id_district NUMBER(10)  not null,
date_update date not null,
constraint FK_Sovet_District FOREIGN KEY (id_district) REFERENCES CL_District (id_district)  
);
SELECT * FROM wrk_GEO;

insert into CL_Sovet
select distinct t1*1000000+t2*1000+t3 id,  sovet, t1*1000+t2 parent_id, 
(select max(sub.datav) from wrk_GEO sub where w.t1*1000+w.t2=sub.t1*1000+sub.t2) date_update  
from wrk_GEO w where  sovet is not null and raion is not null ; -- 1553 сельских советы (районного подчинения ) /1335 без повторений

--SELECT * FROM CL_Sovet;


create table CL_Location
(id_location NUMBER(10) Primary key,
--location_code NUMBER(10) not null,
location_name varchar(100) not null,
id_parent NUMBER(10) not null,
date_update date not null,
constraint FK_Location_Sovet FOREIGN KEY (id_parent) REFERENCES CL_Sovet (id_sovet)  
);

 insert into CL_Location
 select soato, name, t1*1000000+t2*1000+t3 parent_id, datav
 from wrk_GEO where  sovet is not null and raion is not null
 ; --order by 1,2,3-- 27189  нас. пункты (сель/сов)  /23403



 /*ERROR_*/ 
exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CL_Location','TABLE');
exec dbms_errlog.create_error_log('CL_Location','ERROR_CL_Location') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CL_Sovet','TABLE');
exec dbms_errlog.create_error_log('CL_Sovet','ERROR_CL_Sovet') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CL_District','TABLE');
exec dbms_errlog.create_error_log('CL_District','ERROR_CL_District') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CL_Country','TABLE');
exec dbms_errlog.create_error_log('CL_Country','ERROR_CL_Country') ;

exec FRAMEWORK.PKG_UTL_DROP.proc_drop_obj('ERROR_CL_Region','TABLE');
exec dbms_errlog.create_error_log('CL_Region','ERROR_CL_Region') ;



/*

--union all
select distinct 'OBL'||t1 par_id, 'TOWN'||t2||t3 child_id,   obl,  name from wrk_GEO s  
where raion is null and obl is not null                                              --130 города (обл. подчинение)
;
*/
select oblast.t1 ,oblast.obl, city.name from
(select distinct t1, obl from wrk_GEO s where obl is not null order by obl --6 области (РБ)
) oblast
inner join 
(select distinct t1, name from wrk_GEO s where obl is null and name is not null order by name --6 областных города (РБ)
) city on oblast.t1=city.t1
union 
select t1,'МИНСКАЯ ОБЛАСТЬ',  name  from wrk_GEO s where name='Минск' ;
/*select distinct 'RAI'||t1||t2 , to_char(soato), raion ||' район',  name
 from wrk_GEO where  sovet is null and raion is not null                   -- 213 нас. пункты (районного подчинения )
;-- union all
