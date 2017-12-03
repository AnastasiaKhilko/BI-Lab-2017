create table cls_fact_purchaces as
select purchace_id, cf.flight_id, passenger_id, ca.airline_id, service_class_id, purchace_date, airport_to_id, airport_from_id, price
from ce_purchaces cp
join ce_payments pay on cp.payment_id = pay.payment_id
join ce_flights cf on cp.flight_id = cf.flight_id
join ce_airlines ca on ca.airline_id = cf.airline_id
join ce_routes cr on cr.route_id = cf.route_id;