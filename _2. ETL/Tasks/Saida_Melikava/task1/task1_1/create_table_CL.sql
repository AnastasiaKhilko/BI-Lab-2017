CREATE TABLE cl_global
  (
    global_id   NUMBER(10,0),
    global_desc VARCHAR2 ( 200 CHAR )
  );
CREATE TABLE cl_continents
  (
    continent_id   NUMBER(10,0),
    continent_desc VARCHAR2 ( 200 CHAR ),
    global_id      NUMBER(10,0)
  );
CREATE TABLE cl_regions
  (
    region_id    NUMBER(10,0),
    region_desc  VARCHAR2 ( 200 CHAR ),
    continent_id NUMBER(10,0)
  );
CREATE TABLE cl_countries
  (
    country_id   NUMBER(10,0),
    country_desc VARCHAR2 ( 200 CHAR ),
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER(10,0)
  );
  
  
INSERT INTO cl_global
  (global_id, global_desc
  )
SELECT child_code,
  structure_desc
FROM src.ext_geo_structure_iso3166
WHERE structure_level='World';

INSERT INTO cl_continents
  (continent_id, continent_desc,global_id
  )
SELECT child_code,
  structure_desc,
  parent_code
FROM src.ext_geo_structure_iso3166
WHERE structure_level='Continents';

INSERT INTO cl_regions
  (region_id, region_desc,continent_id
  )
SELECT child_code,
  structure_desc,
  parent_code
FROM src.ext_geo_structure_iso3166
WHERE structure_level='Regions';

INSERT INTO cl_countries
  (country_id, country_code,country_desc, region_id
  )
SELECT coun.country_id,
  country_code,
  country_desc,
  structure_code
FROM src.ext_geo_countries_iso3166 coun
INNER JOIN src.ext_cntr2structure_iso3166 struc
ON coun.country_id=struc.country_id;

SELECT * FROM cl_global;
SELECT * FROM cl_continents;
SELECT * FROM cl_regions;
SELECT * FROM cl_countries;
