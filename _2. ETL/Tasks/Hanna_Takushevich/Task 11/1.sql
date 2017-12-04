--The most popular routes from Canada
select air_f.airport_name as airport_name_from, air_t.airport_name as airport_name_to, count(*) as count_of_purchaces
from fact_purchaces pur
join dim_airports air_f on pur.airport_from_surr_id = air_f.airport_surr_id
join dim_airports air_t on pur.airport_to_surr_id = air_t.airport_surr_id
where air_f.country_name = 'Canada'
group by air_f.airport_name, air_t.airport_name
order by 3 desc;

--Demand for classes of service
select service_class_name, count(*) as count_of_purchaces from
fact_purchaces f
join
dim_service_classes_scd cl on f.service_class_surr_id = cl.service_class_surr_id
group by service_class_name
order by 2 desc;

--Profit by years
select dateyear, count(*), sum(price)
from fact_purchaces fp join dim_date dd on fp.purchace_date = dd.date_id
group by dateyear
order by 1;