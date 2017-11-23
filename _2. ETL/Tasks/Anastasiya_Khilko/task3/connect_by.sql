SELECT child_type, child_desc, LTRIM(SYS_CONNECT_BY_PATH(CHILD_DESC, '/'),'/') as Path,
 CASE 
  WHEN level = 1 AND CONNECT_BY_ISLEAF !=1
  THEN 'ROOT'
  WHEN level > 1 AND CONNECT_BY_ISLEAF !=1
  THEN 'BRANCH'
  WHEN level > 1 AND CONNECT_BY_ISLEAF =1
  THEN 'LEAF'
  ELSE 'ROOD AND LEAF'
  END AS h_level,
prior parent_desc as parent,
CONNECT_BY_ROOT id as Root
FROM geo_data
START WITH pid is null
CONNECT BY NOCYCLE PRIOR id = pid
order by level;