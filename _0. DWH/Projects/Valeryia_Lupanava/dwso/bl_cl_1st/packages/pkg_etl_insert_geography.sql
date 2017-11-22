CREATE OR REPLACE PACKAGE pkg_etl_insert_geography
AUTHID CURRENT_USER
AS
  PROCEDURE insert_table_continents;
  PROCEDURE insert_table_regions;
  PROCEDURE insert_table_countries;
						
END pkg_etl_insert_geography;

CREATE OR REPLACE PACKAGE BODY pkg_etl_insert_geography
AS
---------------------------------------------------  
PROCEDURE insert_table_continents
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_continents');
  INSERT INTO cls_continents (
                              continent_id,
                              continent_desc
                            )
  SELECT child_code, 
         structure_desc
  FROM   wrk_structures
  WHERE  
         structure_level LIKE 'Continents';

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;

END insert_table_continents;
---------------------------------------------------  
PROCEDURE insert_table_regions
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_regions');
  INSERT INTO cls_regions (
                              region_id,
                              region_desc,
                              continent_id
                            )
  SELECT 
         child_code, 
         structure_desc,
         parent_code
  FROM   wrk_structures
  WHERE 
         structure_level LIKE 'Regions';

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_regions;
---------------------------------------------------  
PROCEDURE insert_table_countries
IS
BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE cls_countries');
  INSERT INTO cls_countries (
                              country_id,
                              country_desc,
                              country_code,
                              region_id
                            )
  SELECT DISTINCT
                  wcs.country_id, 
                  wcs.county_desc,
                  wc.country_code,
                  wcs.structure_code
  FROM            wrk_full_data wcs LEFT JOIN 
                  wrk_countries wc  ON wcs.country_id = wc.country_id;

  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
  RAISE;
  
END insert_table_countries;
--------------------------------------------------- 

END pkg_etl_insert_geography;