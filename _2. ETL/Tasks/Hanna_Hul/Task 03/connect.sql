SELECT g.ID ,
  g.NAME ,
  ltrim ( SYS_CONNECT_BY_PATH ( NAME, '==>' ), '==>' ) AS PATH ,
  level lvl ,
 -- CONNECT_BY_ISLEAF ,
  (CASE
    WHEN level = 1
    THEN 'Yes'
    else 'NO'
  END) AS ROOT ,
   (CASE
    WHEN level = 2
    THEN 'Yes'
    else 'NO'
  END) AS BRANCH ,
     (CASE
    WHEN level = 3
    THEN 'Yes'
    else 'NO'
  END) AS LEAF,

  (SELECT COUNT(*) FROM GEO START WITH parent_id = g.ID CONNECT BY PRIOR ID = parent_id
  ) AS Children
FROM GEO g
  START WITH parent_id     IS NULL
  CONNECT BY prior ID = Parent_id
ORDER SIBLINGS BY 2 ;
