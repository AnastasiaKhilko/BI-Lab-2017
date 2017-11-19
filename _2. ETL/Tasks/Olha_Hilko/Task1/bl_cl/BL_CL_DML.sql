  
TRUNCATE TABLE wrk_geo_countries_iso3166;
INSERT INTO  wrk_geo_countries_iso3166 SELECT * FROM SRC.ext_geo_countries_iso3166;
TRUNCATE TABLE wrk_geo_structure_iso3166;
INSERT INTO  wrk_geo_structure_iso3166 SELECT * FROM SRC.ext_geo_structure_iso3166;
TRUNCATE TABLE wrk_cntr2structure_iso3166;
INSERT INTO  wrk_cntr2structure_iso3166 SELECT * FROM SRC.ext_cntr2structure_iso3166;
