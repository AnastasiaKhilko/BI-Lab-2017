--CLS_MANUFACTURER_INSERT
TRUNCATE TABLE cls_manufacturers;
INSERT INTO cls_manufacturers (
                              manufacturer_id,
                              manufacturer_code,
                              manufacturer_name,
                              phone,
                              address,
                              city,
                              insert_dt,
                              update_dt
                            )
  SELECT manufacturer_code || '-' || TRUNC(dbms_random.value(1,1000000)) AS manufacturer_id,
         manufacturer_code,
         manufacturer_name,
         phone,
         address,
         cit.city_id,
         insert_dt,
         SYSDATE AS update_dt
  FROM   wrk_manufacturers mnf left join wrk_cities cit on mnf.city = cit.city_desc
  WHERE  cit.city_desc IS NOT NULL and manufacturer_name is not null;

  COMMIT;
