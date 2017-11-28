TRUNCATE TABLE cl_country;
INSERT INTO cl_country
SELECT country.country_id AS country_num,
  country.county_desc     AS country_name,
  country.structure_code  AS region_num
FROM
  (SELECT DISTINCT country_id, county_desc,structure_code FROM wrk_geo_data
  ) country
WHERE country_id   IS NOT NULL
AND county_desc    IS NOT NULL
AND structure_code IS NOT NULL;
