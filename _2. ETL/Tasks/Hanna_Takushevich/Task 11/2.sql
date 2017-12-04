--script for star
select airline_name, airport_name as airport_name_from, service_class_name, sum(price)
from fact_purchaces pur join dim_airlines air on pur.airline_surr_id = air.airline_surr_id
join dim_airports ap on ap.airport_surr_id = pur.airport_from_surr_id
join dim_service_classes_scd scs on scs.service_class_surr_id = pur.service_class_surr_id
group by airline_name, airport_name, service_class_name
having airline_name = 'Fly Air';

--script for 3nf
select airline_name, airport_name as airport_name_from, class_name, sum(price)
from ce_purchaces cp 
join ce_payments pay on cp.payment_id = pay.payment_id
join ce_service_classes csc on csc.class_id = pay.service_class_id
join ce_flights fl on fl.flight_id = cp.flight_id
join ce_routes ro on fl.route_id = ro.route_id
join ce_airports air on ro.airport_from_id = air.airport_id
join ce_airlines al on al.airline_id = fl.airline_id
group by airline_name, airport_name, class_name;