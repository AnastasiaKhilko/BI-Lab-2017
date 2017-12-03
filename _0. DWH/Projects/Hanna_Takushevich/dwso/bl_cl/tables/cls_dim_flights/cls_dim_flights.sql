--==============================================================
-- Table: t_cls_dim_flights
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_dim_flights', Object_Type=>'TABLE');
CREATE TABLE cls_dim_flights AS
SELECT flight_id,
  cf.route_id,
  cf.aircraft_id,
  flight_code,
  route_code,
  aircraft_type,
  engines_num,
  flight_duration,
  flight_date
FROM ce_flights cf
JOIN ce_aircrafts ca
ON cf.aircraft_id = ca.aircraft_id
JOIN ce_routes r
ON r.route_id = cf.route_id;