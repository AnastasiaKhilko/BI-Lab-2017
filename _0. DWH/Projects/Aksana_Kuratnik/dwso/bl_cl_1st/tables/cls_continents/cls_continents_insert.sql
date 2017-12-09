--CLS_CONTINENTS_INSERT.
TRUNCATE TABLE cls_continents;
INSERT INTO cls_continents
  ( continent_id, continent_name
  )
SELECT child_code,
  structure_name
FROM wrk_geo_structures
WHERE structure_level LIKE 'Continents';
COMMIT;