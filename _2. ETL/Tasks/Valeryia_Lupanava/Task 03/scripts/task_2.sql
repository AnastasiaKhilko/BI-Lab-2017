------------------------------------------------
WITH m (id, 
        name, 
        prt, 
        lvl) 
AS
 (SELECT id, 
         name, 
         prt, 
         0 lvl
  FROM  geo
  WHERE prt IS NULL
UNION ALL
  SELECT e.id, 
         e.name, 
         m.id,
         m.lvl + 1
  FROM geo e, m
  WHERE e.prt = m.id)
SEARCH DEPTH FIRST by id ASC SET ordseq
CYCLE id SET is_cycle TO 1 DEFAULT 0
SELECT name 
       , id 
       , prt as parent_is
       , lvl as level_is
       , (CASE WHEN lvl = 0 THEN NAME 
               WHEN lvl = 1 THEN '  ' || NAME 
               WHEN lvl = 2 THEN '    ' || NAME END) as HIERARCHY
       , (CASE WHEN lvl = 0 THEN 'Branch' 
               WHEN lvl = 1 THEN 'Root' 
               WHEN lvl = 2 THEN 'Leaf' END) as Entity
FROM m t
ORDER BY ordseq;
------------------------------------------------
