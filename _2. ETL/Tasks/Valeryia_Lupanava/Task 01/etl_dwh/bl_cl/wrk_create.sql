--Creating WRK tables.

CREATE TABLE wrk_full_data
  (
    country_id     NUMBER(10,0),
    county_desc    VARCHAR2(200 CHAR),
    structure_code NUMBER(10,0),
    structure_desc VARCHAR2(200 CHAR)
  );
  
CREATE TABLE wrk_structures
  (
    child_code      NUMBER(10,0),
    parent_code     NUMBER(10,0),
    structure_desc  VARCHAR2(200 CHAR),
    structure_level VARCHAR2(200 CHAR)
  );
  
CREATE TABLE wrk_countries
  (
    country_id   NUMBER ( 10 ),
    country_desc VARCHAR2 ( 200 CHAR ),
    country_code VARCHAR2 ( 3 )
  );