--WRK_SELLERS_INSERT.
TRUNCATE TABLE cls_sellers;
INSERT
INTO cls_sellers
  (
    seller_id,
    first_name,
    last_name,
    gender,
    age,
    email,
    phone,
    address,
    city_id,
    start_dt,
    end_dt,
    is_active
  )
SELECT seller_code AS seller_id,
  first_name,
  last_name,
  gender,
  age,
  email,
  address,
  city_id,
  phone,
  start_dt,
  end_dt,
  is_active
FROM wrk_sellers we
INNER JOIN wrk_cities wct
ON we.city = wct.city_desc;
COMMIT;