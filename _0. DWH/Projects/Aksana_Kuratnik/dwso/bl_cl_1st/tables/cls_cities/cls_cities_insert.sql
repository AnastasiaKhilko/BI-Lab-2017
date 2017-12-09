--CLS_CITIES_INSERT.
INSERT INTO cls_cities (
                              city_id,
                              city_desc,
                              country_id
                            )
  SELECT city_id,
        city_desc,
        country_id
  FROM  wrk_cities
  WHERE city_id IS NOT NULL 
    AND city_desc IS NOT NULL
    AND country_id IS NOT NULL;

  COMMIT;