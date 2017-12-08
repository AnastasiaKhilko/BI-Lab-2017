create materialized view mv_01
refresh
force
on demand
enable query rewrite as
select 
      -- dim_locations.city,
       nvl(dim_date.year_id,'All years'),
       nvl(dim_hotels.hotel_name,'All hotels'),
       sum(amount*discount/100)
from 
      fct_orders,
      dim_hotels,
      dim_date
where fct_orders.hotel_id = dim_hotels.hotel_dwh_id AND
fct_orders.check_in_date = dim_date.date_id
group by  CUBE(dim_date.year_id,dim_hotels.hotel_name)
order by grouping_id(dim_hotels.hotel_name),2,1;

--grant create materialized view to bl_dwh;

select * from mv_01;
delete from fct_orders where customer_id = 2018;
execute dbms_mview.refresh('mv_01');
select * from mv_01 order by 2,1;
---------------------------------------------------------------

drop table t1;
create table t1 (
id number primary key,
par varchar(5)
);
insert into t1 values(2,'a');
commit;
CREATE MATERIALIZED VIEW LOG ON t1;
create materialized view mv_02
refresh
fast
on commit
as
select 
      id,
      par
from  t1;

select * from mv_02;

insert into t1 values(3,'b');
select * from mv_02;
commit;
select * from mv_02;