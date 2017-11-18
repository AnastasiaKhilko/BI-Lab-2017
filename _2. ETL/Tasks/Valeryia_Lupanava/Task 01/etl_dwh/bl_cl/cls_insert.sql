-- Filling with data.

INSERT INTO cls_continents
SELECT 
   child_code, 
   structure_desc
FROM wrk_structures
WHERE 
   structure_level LIKE 'Continents';
   
INSERT INTO cls_regions
SELECT 
   child_code, 
   structure_desc,
   parent_code
FROM wrk_structures
WHERE 
   structure_level LIKE 'Regions';

INSERT INTO cls_countries
SELECT DISTINCT
   wcs.country_id, 
   wcs.county_desc,
   wc.country_code,
   wcs.structure_code
FROM wrk_full_data wcs LEFT JOIN 
     wrk_countries wc 
  ON wcs.country_id = wc.country_id;
  
COMMIT;