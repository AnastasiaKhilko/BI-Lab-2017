CREATE VIEW geo_data AS
SELECT 'world'
  || world_id AS id,
  world_desc  AS child_desc,
  'world'     AS child_type,
  NULL        AS pid,
  NULL        AS parent_type,
  NULL        AS parent_desc
FROM ce_world
UNION ALL
SELECT 'con'
  || cc.continent_id AS id,
  cc.continent_desc  AS child_desc,
  'Continent'        AS child_type,
  'world'
  || cc.world_id AS pid,
  'World'        AS parent_type,
  w.world_desc   AS parent_desc
FROM CE_CONTINENTS cc
LEFT JOIN ce_world w
ON cc.WORLD_ID = w.WORLD_ID
UNION ALL
SELECT 'reg'
  || r.region_id AS id,
  r.region_desc  AS child_desc,
  'Region'       AS child_type,
  'con'
  || r.continent_id AS pid,
  'Continent'       AS parent_type,
  c.continent_desc  AS parent_desc
FROM ce_regions r
LEFT JOIN ce_continents c
ON r.continent_id = c.continent_id
UNION ALL
SELECT 'country'
  || c1.country_id AS id,
  c1.country_desc  AS child_desc,
  'Country'        AS child_type,
  'reg'
  || rr.region_id AS pid,
  'Region'        AS parent_type,
  rr.region_desc  AS parent_desc
FROM ce_countries c1
LEFT JOIN ce_regions rr
ON c1.REGION_ID = rr.REGION_ID;

select * from geo_data;

SELECT parent_type, parent_desc , child_type , child_desc, level, LTRIM(SYS_CONNECT_BY_PATH(CHILD_DESC, '/'),'/') as Path,
CONNECT_BY_ISLEAF as leaf,
prior pid as parent,
CONNECT_BY_ROOT id as Root
--CONNECT_BY_ISCYCLE parent_desc as cc
FROM geo_data
START WITH pid is null
CONNECT BY NOCYCLE PRIOR id = pid
order by level;

select SYS_CONNECT_BY_PATH(parent_desc, '/') as path
from geo_data
start with pid is null
connect by prior id = pid;