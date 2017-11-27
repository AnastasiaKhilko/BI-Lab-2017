TRUNCATE table wrk_cities;

INSERT INTO wrk_cities (
                        city_id,
                        city_desc,
                        country_id                        
                        )
SELECT        
       wrk_cities_seq.nextval,
       city_desc,
       country_id
FROM (SELECT DISTINCT city AS city_desc,
                      country_id
      FROM sa_src.ext_customers);