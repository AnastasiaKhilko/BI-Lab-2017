INSERT
INTO dim_airports
  (
    airport_surr_id,
    airport_id,
    city_id,
    airport_name, 
    airport_iata, 
    airport_icao, 
    airport_faa, 
    city_name, 
    country_name, 
    subregion_name, 
    region_name,
    insert_dt,
    update_dt
  )
  VALUES
  (
    -99
  , -1
  , -1
  ,'n.d.'
  ,'n.'
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,'n.d.'
  ,null
  ,null
  );
COMMIT;