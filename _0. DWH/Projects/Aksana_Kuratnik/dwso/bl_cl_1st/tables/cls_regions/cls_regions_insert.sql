--CLS_REGIONS_INSERT
TRUNCATE TABLE cls_regions;
INSERT INTO cls_regions
  ( region_id, region_desc, continent_id
  )
SELECT child_code,
  structure_name,
  parent_code
FROM wrk_geo_structures
WHERE structure_level LIKE 'Regions';
COMMIT;