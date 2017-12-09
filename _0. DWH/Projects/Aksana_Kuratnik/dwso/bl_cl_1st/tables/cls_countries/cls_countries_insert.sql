--CLS_COUNTRIES_INSERT.
INSERT
INTO cls_countries
  (
    country_id,
    country_desc,
    country_code,
    region_id
  )
SELECT DISTINCT geo.country_id,
  geo.county_name,
  wc.country_code,
  geo.structure_id
FROM wrk_geo_data geo
LEFT JOIN wrk_countries wc
ON geo.country_id = wc.country_id;
COMMIT;