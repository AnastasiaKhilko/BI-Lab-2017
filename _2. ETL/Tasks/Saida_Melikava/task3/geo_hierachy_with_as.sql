WITH par(ids,descs,parents,lvl,path) AS
  (SELECT ids,
    descs,
    parents ,
    0,
    descs AS path
  FROM hier
  WHERE hier.parents IS NULL
  UNION ALL
  SELECT chld.ids,
    chld.descs,
    chld.parents,
    t.lvl+1,
    t.path
    ||'==>'
    ||chld.descs
  FROM hier chld
  JOIN par t
  ON chld.parents=t.ids
  )search depth FIRST BY descs
  SET q,
  a as
(
select count(*) cnt,d
from
(SELECT connect_by_root(descs) d
FROM hier
where level>1
connect by
prior ids=parents)
group by d
)
SELECT ids,
  descs,
  parents,
  lvl,
  q,
  path,
  a.cnt as count_of_child,
  CASE
    WHEN lvl=
      (SELECT MAX(lvl) FROM par
      )
    THEN 'child'
    WHEN lvl=
      (SELECT MIN(lvl) FROM par
      )
    THEN 'root'
    ELSE 'branch'
  END AS branch_root_leaf
FROM par,a
where a.d=par.descs
ORDER BY q;
