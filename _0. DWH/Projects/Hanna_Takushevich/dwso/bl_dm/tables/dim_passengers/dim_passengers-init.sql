INSERT
INTO dim_passengers
  (
    passenger_surr_id ,
    passenger_id,
    passenger_code,
    given_name,
    middle_name,
    last_name,
    city,
    country_abbr,
    email,
    phone,
    birthday,
    insert_dt,
    update_dt
  )
  VALUES
  (
    -99
  , -1
  , -1
  , 'n.d'
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,'n'
  ,'n.d.'
  ,'n.d'
  ,null
  ,null
  ,null
  );
COMMIT;