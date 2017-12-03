--CLS_MANUFACTURER_INSERT
INSERT INTO cls_manufacturers (
                              manufacturer_id,
                              manufacturer_code,
                              manufacturer_name,
                              phone,
                              address,
                              city_id,
                              insert_dt,
                              update_dt
                            )
  SELECT manufacturer_code || '-' || SUBSTR(phone,1,3) AS manufacturer_id,
         manufacturer_code,
         manufacturer_name,
         phone,
         address,
         mnf.city,
         insert_dt,
         SYSDATE AS update_dt
  FROM   wrk_manufacturers mnf left join wrk_cities cit on mnf.city = cit.city_name
  WHERE  cit.city_id IS NOT NULL;

  COMMIT;
