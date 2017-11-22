select 
      -- dim_locations.city,
       nvl(dim_date.year_id,'All years'),
       nvl(dim_locations.country,'All countries'),
       sum(amount*discount/100)
from 
      fact_order,
      dim_locations,
      dim_date
where fact_order.location_id = dim_locations.location_id AND
fact_order.date_id = dim_date.date_id
group by  CUBE(dim_date.year_id,dim_locations.country)
order by grouping_id(dim_locations.country),2,1;
       