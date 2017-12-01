TRUNCATE TABLE cl_region;
INSERT INTO cl_region
SELECT rn.structure_code AS region_num,
  rn.structure_desc     AS region_name
FROM
  (SELECT DISTINCT structure_code, structure_desc FROM wrk_geo_data
  ) rn
WHERE structure_code IS NOT NULL
AND structure_desc  IS NOT NULL ;
