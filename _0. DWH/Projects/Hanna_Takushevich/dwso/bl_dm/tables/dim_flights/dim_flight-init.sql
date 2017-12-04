INSERT
INTO dim_flights
  (
    flight_surr_id,
    flight_id,
    route_id,
    aircraft_id,
    flight_code,
    route_code,
    aircraft_type,
    engines_num,
    flight_duration,
    flight_date,
    insert_dt,
    update_dt 
  )
  VALUES
  (
    -99
  , -1
  , -1
  , -1
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,-1
  ,'n.d.'
  ,null
  ,null
  ,null
  );
COMMIT;