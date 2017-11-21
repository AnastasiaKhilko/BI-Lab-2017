WITH t AS
  (SELECT MAX(level) AS maxl,
    MIN(level)       AS minl
  FROM hier
    START WITH parents IS NULL
    CONNECT BY prior ids=parents
  ) ,
  a AS
  (SELECT COUNT(*) cnt,
    d
  FROM
    (SELECT connect_by_root(descs) d
    FROM hier
    WHERE level           >1
      CONNECT BY prior ids=parents
    )
  GROUP BY d
  )
SELECT ids,
  descs,
  parents,
  level lvl,
  a.cnt AS count_of_child,
  CASE
    WHEN level=t.maxl
    THEN 'child'
    WHEN level=t.minl
    THEN 'root'
    ELSE 'branch'
  END                                           AS branch_root_leaf,
  ltrim(sys_connect_by_path(descs,'==>'),'==>') AS hierachy
FROM hier,
  t,
  a
WHERE a.d             =hier.descs
  START WITH parents IS NULL
  CONNECT BY prior ids=parents ;
