 SELECT * FROM EXT_GEO_STRUCTURE_ISO3166 ORDER BY parent_code nulls
  FIRST;

 SELECT * FROM EXT_GEO_STRUCTURE_ISO3166 WHERE parent_code IS NULL;

 INSERT INTO CLS_GEO_STRUCTURE VALUES
  ( 1123, NULL, 'Mars', 'World'
  ) ;

 CREATE TABLE t_worlds
  (
    world_id          NUMBER
  , world_code        NUMBER
  , world_description VARCHAR2 ( 100 )
  ) ;

CREATE SEQUENCE seq_worlds INCREMENT BY 1 START WITH 1 MINVALUE 1
  NOCYCLE;
  /

   CREATE TABLE cls_geo_structure AS
   SELECT *
     FROM EXT_GEO_STRUCTURE_ISO3166
    WHERE 1 = 0;
  /********cleansing*************/
  /*****************************/
  merge INTO t_worlds t USING
  ( SELECT WORLD_CODE, WORLD_DESCRIPTION FROM t_worlds
    MINUS
   SELECT child_code
  , structure_desc
     FROM cls_geo_structure
    WHERE STRUCTURE_LEVEL   = 'World'
  ) cls ON ( cls.WORLD_CODE = t.world_code )
WHEN matched THEN
   UPDATE SET t.WORLD_DESCRIPTION = cls.WORLD_DESCRIPTION WHEN NOT
    matched THEN
   INSERT
    (
      WORLD_ID
    , WORLD_CODE
    , WORLD_DESCRIPTION
    )
    VALUES
    (
      seq_worlds.nextval
    , cls.WORLD_CODE
    , cls.WORLD_DESCRIPTION
    ) ;
  COMMIT;

   DELETE
     FROM t_worlds
    WHERE WORLD_CODE NOT IN
    ( SELECT child_code FROM cls_geo_structure WHERE STRUCTURE_LEVEL
      = 'World'
    ) ;
  BEGIN
    --pkg_etl_geo.load_cls_geo_structure;
    pkg_etl_geo.load_worlds;

  END;
  /

   SELECT * FROM t_worlds;

   SELECT COUNT ( * ) FROM cls_geo_structure;

WITH cust AS
  (SELECT
    /*+gather_plan_statistics */
    b.cust_income_level
  , a.country_name
     FROM sh.customers b
  JOIN sh.countries a
       ON a.country_id = b.country_id
  )
 SELECT country_name
, cust_income_level
, COUNT ( country_name ) country_cust_count
   FROM cust c
  WHERE country_name >
  ( SELECT COUNT ( * ) * .01 FROM cust c2
  ) ;

 SELECT plan_table_output
   FROM TABLE ( dbms_xplan.display_cursor ( format=>'ALLSTATS LAST' )
  ) ;

 SELECT *
   FROM v$sql
  WHERE sql_text LIKE '%cust_income_level%'
ORDER BY LAST_ACTIVE_TIME DESC;

WITH avg_emp AS
  (SELECT
    /*+materialize*/
    department_id
  , AVG ( salary ) avg_sal
     FROM hr.employees
 GROUP BY department_id
  )
 SELECT *
   FROM hr.employees e
, avg_emp ade
  WHERE e.salary    > ade.avg_sal
AND e.department_id = ade.department_id;

 SELECT *
   FROM HR.EMPLOYEES
  WHERE manager_id =
  ( SELECT employee_id FROM HR.EMPLOYEES WHERE MANAGER_ID IS NULL
  )
UNION ALL
 SELECT * FROM HR.EMPLOYEES WHERE MANAGER_ID IS NULL ;

 SELECT EMPLOYEE_ID
, FIRST_NAME
  ||' '
  ||LAST_NAME ln
, ltrim ( SYS_CONNECT_BY_PATH ( LAST_NAME, '==>' ), '==>' )
, level lvl
, CONNECT_BY_ISLEAF
, lpad ( ' ', ( level - 1 ) * 2, ' ' )
  || FIRST_NAME
  ||' '
  ||LAST_NAME last_name
   FROM HR.EMPLOYEES
  START WITH MANAGER_ID       IS NULL
  CONNECT BY prior employee_id = manager_id
ORDER SIBLINGS BY 2 ;

WITH emp ( id, name, lvl ) AS
  (SELECT employee_id id
  , FIRST_NAME
    ||' '
    ||LAST_NAME name
  , 0 lvl
     FROM HR.EMPLOYEES
    WHERE MANAGER_ID IS NULL
UNION ALL
   SELECT chld.employee_id
  , chld.FIRST_NAME
    ||' '
    ||chld.LAST_NAME name
  , prnt.lvl + 1
     FROM HR.EMPLOYEES chld
  JOIN emp prnt
       ON chld.manager_id = prnt.id
  ) search depth first BY name set q
 SELECT * FROM emp
 order by q;

 SELECT * FROM v$reserved_words WHERE V$RESERVED_WORDS.KEYWORD =
  'CHILD';
  
  
explain plan for
select * from HR.EMPLOYEES e, HR.EMPLOYEES m
where E.MANAGER_ID(+)=m.EMPLOYEE_ID;

delete from plan_table;

select id, parent_id, position, 
lpad(' ',level-1)||operation||' '||options||' '||object_name
from plan_table
start with id=0
connect by prior id = parent_id
order siblings by position;