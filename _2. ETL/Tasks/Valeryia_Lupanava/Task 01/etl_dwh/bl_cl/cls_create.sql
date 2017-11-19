--Creating CLS tables.

CREATE TABLE cls_continents
  (
    continent_id   NUMBER ( 10 ),
    continent_desc VARCHAR2 ( 200 CHAR )
  );
  
CREATE TABLE cls_regions
  (
    region_id    NUMBER ( 10 ),
    region_desc  VARCHAR2(200 CHAR),
    continent_id NUMBER ( 10 )
  );
  
CREATE TABLE cls_countries
  (
    country_id   NUMBER ( 10 ),
    country_desc VARCHAR2 ( 200 CHAR ),
    country_code VARCHAR2 ( 3 ),
    region_id    NUMBER ( 10 )
  );