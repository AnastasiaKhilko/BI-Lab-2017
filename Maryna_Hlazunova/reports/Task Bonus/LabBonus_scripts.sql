-- task 2
select 
(case when grouping (tm.calendar_month_desc)=1 then 'GRAND_TOTAL' else tm.calendar_month_desc end) as year_month,
(case when grouping (ch.channel_desc)=1 and grouping (tm.calendar_month_desc)=0 then 'Total by Channels' else ch.channel_desc end) as channel,
(case when grouping (cn.country_name)=1 and grouping (ch.channel_desc)=0 and grouping (tm.calendar_month_desc)=0 then ch.channel_desc||' Total by States' else cn.country_name end) as country,
to_char(round(max(sl.amount_sold)), '9,999,999') as max_sales$,
to_char(round(min(sl.amount_sold)), '9,999,999') as min_sales$,
to_char(round(sum(sl.amount_sold)), '9,999,999') as sales$
from sh.sales sl
join sh.times tm on sl.time_id = tm.time_id
join sh.channels ch on sl.channel_id = ch.channel_id
join sh.customers cs on sl.cust_id = cs.cust_id
join sh.countries cn on cs.country_id = cn.country_id
where calendar_month_desc = '2000-12' and channel_desc in ('Internet', 'Direct Sales')
group by rollup(tm.calendar_month_desc, ch.channel_desc, cn.country_name);

--- task3
with  dat as
(select pr.prod_name, 
(case when tm.calendar_quarter_number=1 then sl.amount_sold else null end) as q1,
(case when tm.calendar_quarter_number=2 then sl.amount_sold else null end) as q2,
(case when tm.calendar_quarter_number=3 then sl.amount_sold else null end) as q3,
(case when tm.calendar_quarter_number=4 then sl.amount_sold else null end) as q4,
sl.amount_sold as year_sum
from sh.sales sl 
join sh.times tm on sl.time_id = tm.time_id
join sh.customers cs on sl.cust_id = cs.cust_id
join sh.countries cn on cs.country_id = cn.country_id
join sh.products pr on sl.prod_id = pr.prod_id
where pr.prod_category_desc = 'Photo' and tm.calendar_year = '2000' and cn.country_region = 'Asia')
select nvl(prod_name,'Total') as product, sum(q1) as q1, sum(q2) as q2, sum(q3) as q3, sum(q4) as q4, sum (year_sum) as 
from dat
group by rollup (prod_name);


-- task with pivot
with dat as
(select pr.prod_name, sl.amount_sold, tm.calendar_quarter_number
from sh.sales sl 
join sh.times tm on sl.time_id = tm.time_id
join sh.customers cs on sl.cust_id = cs.cust_id
join sh.countries cn on cs.country_id = cn.country_id
join sh.products pr on sl.prod_id = pr.prod_id
where pr.prod_category_desc = 'Photo' and tm.calendar_year = '2000' and cn. country_region = 'Asia'),
piv as
(select * from dat
pivot
(sum(dat.amount_sold)
for calendar_quarter_number
in(1 as q1, 2 as q2, 3 as q3, 4 as q4))
order by 1)
select (case when grouping (prod_name)=1 then 'Total' else prod_name end) as prod_name,
sum(q1) as q1, sum(q2) as q2, sum(q3) as q3, sum(q4) as q4, nvl(sum(q1),0)+nvl(sum(q2),0)+nvl(sum(q3),2)+nvl(sum(q4),0) as year_sum
from piv
group by rollup (prod_name)
;
