WITH t AS (
    SELECT 
      department_id,
      region AS child_code,
      null AS parent_code
    FROM dim_departments
      UNION ALL
    SELECT 
      department_id,
      country, 
      region 
    FROM dim_departments
      UNION ALL 
    SELECT 
      department_id,
      city, 
      country
    FROM dim_departments)
SELECT 
  ltrim(sys_connect_by_path(child_code,'==>'), '==>' ) AS path
FROM t 
START WITH
  parent_code IS NULL
CONNECT BY
  PRIOR child_code = parent_code;
  

