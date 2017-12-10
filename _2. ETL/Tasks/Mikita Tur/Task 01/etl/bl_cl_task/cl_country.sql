Create table cl_country
  (
    country_id number(10),
    country_desc varchar2(100 char),
    country_code varchar2(5),
    region_id number(10)
  );
INSERT INTO cl_country
  (country_id, country_code,country_desc, region_id
  )
SELECT EXT_COUNTRIES.country_id,
  country_code,
  country_desc,
  structure_code
FROM sa_src_task.EXT_COUNTRIES 
INNER JOIN sa_src_task.EXT_geo_un_countries
ON EXT_COUNTRIES.country_id=EXT_geo_un_countries.country_id;
commit;