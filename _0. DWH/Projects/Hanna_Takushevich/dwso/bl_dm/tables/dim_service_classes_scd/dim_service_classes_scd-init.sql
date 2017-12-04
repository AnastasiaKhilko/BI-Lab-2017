INSERT
INTO dim_service_classes_scd
  (
    service_class_surr_id,
    service_class_id,
    service_class_code,
    service_class_name,
    seat_letter,
    menu,
    max_luggage,
    service_class_desc,
    start_dt,
    end_dt,
    insert_dt
  )
  VALUES
  (
    -99
  , -1
  , 'n.d'
  , 'n.d'
  ,'n'
  ,'n.d.'
  ,-1
  ,'n.d.'
  ,null
  ,null
  ,null
  );
COMMIT;