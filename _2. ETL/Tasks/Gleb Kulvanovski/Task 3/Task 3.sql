--DROP VIEW dem_loc;


CREATE VIEW dem_loc AS
SELECT 'WOR1' AS Child_id, 'WORLD' AS Child_Name, NULL AS Par_id, NULL AS PAR_NAME
FROM DUAL
UNION
SELECT 'CON' || to_char(continent_id) AS Child_id, continent_name AS Child_name, 'WOR1' AS Par_id, 'WORLD' AS Par_Name
FROM Continents
UNION
SELECT 'REG' || to_char(reg.region_id), region_name, 'CON' || to_char(con.Continent_id), Continent_name
FROM Continents con JOIN Regions reg ON con.continent_id = reg.continent_id
UNION 
SELECT 'COU' || to_char(ct.country_id), country_name,  'REG' || to_char(reg.region_id), region_name
FROM Regions reg
JOIN Countries ct ON reg.region_id  = ct.region_id;



SELECT CHILD_ID, CHILD_NAME, PAR_ID, PAR_NAME, LTRIM(SYS_CONNECT_BY_PATH(CHILD_NAME, '/'), '/') AS Hierarchy,
  CASE 
  WHEN level = 1 AND CONNECT_BY_ISLEAF !=1
  THEN 'ROOT'
  WHEN level > 1 AND CONNECT_BY_ISLEAF !=1
  THEN 'BRANCH'
  WHEN level > 1 AND CONNECT_BY_ISLEAF =1
  THEN 'LEAF'
  ELSE 'ROOD AND LEAF'
  END AS tt,
  (SELECT COUNT(*) FROM dem_loc  WHERE dc.child_id = par_id) AS "Count of Children"
FROM dem_loc dc
START WITH PAR_ID IS NULL
CONNECT BY PRIOR child_id = par_id
ORDER SIBLINGS BY 1, 3;




WITH par (CHILD_ID ,CHILD_NAME, PAR_ID, PAR_NAME, Hierarchy, TT,  "Count of Children") AS (
  SELECT CHILD_ID ,CHILD_NAME, PAR_ID, PAR_NAME, CHILD_NAME AS Hierarchy, 'ROOT' AS TT,
         (SELECT COUNT(*) FROM dem_loc  WHERE dc.child_id = par_id) AS "Count of Children"
  FROM dem_loc dc
  WHERE par_id IS NULL
  UNION ALL
  SELECT dl.CHILD_ID ,dl.CHILD_NAME, dl.PAR_ID, dl.PAR_NAME, par.Hierarchy || '\' || dl.CHILD_NAME AS Hierarchy,
          CASE 
          WHEN (SELECT COUNT(*) FROM dem_loc  WHERE dl.child_id = par_id) != 0 
          THEN 'BRANCH'
          WHEN dl.par_id IS NULL AND (SELECT COUNT(*) FROM dem_loc  WHERE dl.child_id = par_id) = 0 
          THEN 'ROOD AND LEAF'
          ELSE 'LEAF'
          END AS TT,
         (SELECT COUNT(*) FROM dem_loc  WHERE dl.child_id = par_id) AS "Count of Children"
  FROM dem_loc dl
  JOIN par 
  ON dl.par_id = par.child_id)
  SEARCH DEPTH FIRST BY child_id, par_id SET ord
SELECT CHILD_ID, CHILD_NAME, PAR_ID, PAR_NAME, Hierarchy, TT, "Count of Children"
FROM PAR
ORDER BY ord;
