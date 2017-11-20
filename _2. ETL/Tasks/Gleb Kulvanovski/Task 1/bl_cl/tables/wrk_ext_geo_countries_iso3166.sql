-- EXEC system.pckg_drop.DROP_Proc('wrk_ext_geo_countries_iso3166', 'Table'); 

CREATE TABLE wrk_ext_geo_countries_iso3166
  (country_id     NUMBER ( 10 ),
  country_desc   VARCHAR2 ( 200 CHAR ),
  country_code   VARCHAR2 ( 3 )
  );
