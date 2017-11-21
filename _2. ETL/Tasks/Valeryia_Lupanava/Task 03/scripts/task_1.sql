CREATE VIEW GEO AS
SELECT CONTINENT_ID as ID, 
       CONTINENT_DESC as NAME, 
       NULL as PRT, 
       'CONTINENT' as LVL 
FROM CE_CONTINENTS
UNION ALL
SELECT REGION_ID as ID, 
       REGION_DESC as NAME, 
       CONTINENT_ID as PRT, 
       'REGION' as LVL 
FROM CE_REGIONS
UNION ALL
SELECT COUNTRY_ID as ID, 
       COUNTRY_DESC as NAME, 
       REGION_ID as PRT, 
       'COUNTRY' as LVL 
FROM CE_COUNTRIES;

--------------------------------------------------------------

SELECT
  g.ID
, g.NAME
, ltrim ( SYS_CONNECT_BY_PATH ( NAME, '==>' ), '==>' ) as PATH
, level lvl
, CONNECT_BY_ISLEAF
, (CASE WHEN level = 1 THEN NAME WHEN level = 2 
                       THEN '  ' || NAME WHEN level = 3 
                       THEN '    ' || NAME END) as HIERARCHY
, (CASE WHEN level = 1 THEN 'Branch' WHEN level = 2 
                       THEN 'Root' WHEN level = 3 
                       THEN 'Leaf' END) as Entity
, (SELECT COUNT(*) FROM GEO START WITH PRT = g.ID CONNECT BY PRIOR ID = PRT) as Children
FROM GEO g
  START WITH PRT IS NULL
  CONNECT BY prior ID = PRT
ORDER SIBLINGS BY 2 ;

--------------------------------------------------------------