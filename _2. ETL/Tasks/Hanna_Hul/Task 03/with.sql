WITH gd (id, 
        name, 
        parent_id, 
        lvl) 
AS
 (SELECT id, 
         name, 
         parent_id, 
         0 lvl
  FROM  geo
  WHERE parent_id IS NULL
UNION ALL
  SELECT gd_1.id, 
         gd_1.name, 
         gd.id,
         gd.lvl + 1
  FROM geo gd_1, gd
  WHERE gd_1.parent_id = gd.id)
SEARCH DEPTH FIRST by id ASC SET ord
CYCLE id SET is_cycle TO 1 DEFAULT 0
SELECT id 
       ,  name
       , parent_id as parent_is
       , lvl as level_is
      
       , (CASE WHEN lvl = 0 THEN 'Branch' 
               WHEN lvl = 1 THEN 'Root' 
               WHEN lvl = 2 THEN 'Leaf' END) as Entity
FROM gd T
ORDER BY ord;
