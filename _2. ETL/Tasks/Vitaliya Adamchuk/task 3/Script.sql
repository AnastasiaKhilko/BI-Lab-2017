--Task_1
CREATE VIEW GEO_DATA AS
SELECT CONTINENT_ID AS ID,
  CONTINENT_DESC    AS NAME,
  NULL              AS PRT,
  'CONTINENT'       AS LVL
FROM CE_CONTINENTS
UNION ALL
SELECT REGION_ID AS ID,
  REGION_DESC    AS NAME,
  CONTINENT_ID   AS PRT,
  'REGION'       AS LVL
FROM CE_REGIONS
UNION ALL
SELECT COUNTRY_ID AS ID,
  COUNTRY_DESC    AS NAME,
  REGION_ID       AS PRT,
  'COUNTRY'       AS LVL
FROM CE_COUNTRIES;

SELECT g.ID ,
  g.NAME ,
  ltrim ( SYS_CONNECT_BY_PATH ( NAME, '==>' ), '==>' ) AS PATH ,
  level lvl ,
  CONNECT_BY_ISLEAF ,
  (
  CASE
    WHEN level = 1
    THEN NAME
    WHEN level = 2
    THEN '  '
      || NAME
    WHEN level = 3
    THEN '    '
      || NAME
  END) AS HIERARCHY ,
  (
  CASE
    WHEN level = 1
    THEN 'Branch'
    WHEN level = 2
    THEN 'Root'
    WHEN level = 3
    THEN 'Leaf'
  END) AS Entity ,
  (SELECT COUNT(*) FROM GEO_DATA START WITH PRT = g.ID CONNECT BY PRIOR ID = PRT
  ) AS Children
FROM GEO_DATA g
  START WITH PRT     IS NULL
  CONNECT BY prior ID = PRT
ORDER SIBLINGS BY 2 ;


--Task_2
WITH gd (id, 
        name, 
        prt, 
        lvl) 
AS
 (SELECT id, 
         name, 
         prt, 
         0 lvl
  FROM  geo_data
  WHERE prt IS NULL
UNION ALL
  SELECT gd_1.id, 
         gd_1.name, 
         gd.id,
         gd.lvl + 1
  FROM geo_data gd_1, gd
  WHERE gd_1.prt = gd.id)
SEARCH DEPTH FIRST by id ASC SET ord
CYCLE id SET is_cycle TO 1 DEFAULT 0
SELECT id 
       ,  name
       , prt as parent_is
       , lvl as level_is
       , (CASE WHEN lvl = 0 THEN NAME 
               WHEN lvl = 1 THEN '  ' || NAME 
               WHEN lvl = 2 THEN '    ' || NAME END) as HIERARCHY
       , (CASE WHEN lvl = 0 THEN 'Branch' 
               WHEN lvl = 1 THEN 'Root' 
               WHEN lvl = 2 THEN 'Leaf' END) as Entity
FROM gd T
ORDER BY ord;

