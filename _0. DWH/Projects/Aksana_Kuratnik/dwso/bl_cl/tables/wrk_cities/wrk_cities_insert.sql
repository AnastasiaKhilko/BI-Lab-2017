--INSERT TO WRK_CITIES.
TRUNCATE table wrk_cities;
INSERT INTO wrk_cities (
                        city_id,
                        city_name,
                        country_id                        
                        )
SELECT country_id || ' ' || SUBSTR(city_name,1,6) AS city_id,       
       city_name,
       country_id
FROM (SELECT DISTINCT city AS city_name,
                      country_id
      FROM sa_src.ext_customers);
commit;
