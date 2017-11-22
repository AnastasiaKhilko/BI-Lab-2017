CREATE OR REPLACE VIEW location_connect AS
WITH geo AS (
SELECT 
  'WOR'||WORLD_ID AS CHILD_ID, 
  WORLD_ID AS SRC_ID, 
  WORLD_DESC AS DESCRIPTION, 
  NULL AS PARENT_ID 
FROM NF_WORLD 

UNION ALL

SELECT 
  'CON'||CONTINENT_ID, 
  CONTINENT_ID, 
  CONTINENT_DESC,
  'WOR'||WORLD_ID 
FROM NF_CONTINENTS 

UNION ALL

SELECT 
  'REG'||REGION_ID, 
  REGION_ID, 
  REGION_DESC,
  'CON'||CONTINENT_ID 
FROM NF_REGIONS 

UNION ALL

SELECT 
  'CNT'||COUNTRY_ID, 
  COUNTRY_ID, 
  COUNTRY_DESC,
  'REG'||REGION_ID 
FROM NF_COUNTRIES)

    SELECT
        child_id,
        parent_id,
        trim(trailing ' ' FROM description) as descrition,
        ltrim(sys_connect_by_path(trim(trailing ' ' FROM description),'==>'),'==>') AS path,
        (SELECT COUNT(*) FROM geo START WITH parent_id = g.child_id CONNECT BY PRIOR child_id = parent_id) 
          AS "CHILD_NUM",
        level AS lvl,
        DECODE (level, 
          1, '' || trim(trailing ' ' FROM description),
          2, '  ' || trim(trailing ' ' FROM description),
          3, '    ' || trim(trailing ' ' FROM description),
          4, '      ' || trim(trailing ' ' FROM description)) 
            AS hierarchy,
        DECODE (level,
          1, 'Root',
          2, 'Branch',
          3, 'Branch',
          4, 'Leaf')
            AS tree
    FROM geo g
    START WITH
        parent_id IS NULL
    CONNECT BY
        PRIOR child_id = parent_id
    ORDER SIBLINGS BY description;
