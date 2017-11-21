SELECT Parent_id, 
       Name,
       ltrim ( SYS_CONNECT_BY_PATH ( Name, '==>' ), '==>' ) as PATH,
       CASE
          WHEN level = 4 AND connect_by_isleaf = 1 THEN 'Leaf'
          WHEN level = 3 AND connect_by_isleaf = 0 THEN 'Branch'
          WHEN level = 2 AND connect_by_isleaf = 0 THEN 'Branch'
          WHEN level = 1 AND connect_by_isleaf = 0 THEN 'Root'
       END as Definition,
       (SELECT COUNT(*) FROM dim_location dl WHERE dim.parent_id=child_id) AS amount_of_children
FROM dim_location dim 
START WITH child_id IS NULL
CONNECT BY  prior parent_id= child_id 
ORDER SIBLINGS by 2;
