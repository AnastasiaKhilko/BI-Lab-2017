WITH t1 (
    terr_id,
    terr_name,
    terr_over,
    lvl,
    root_id,
    path
) AS (
  -- Anchor member.
    SELECT
        terr_id,
        terr_name,
        terr_over,
        1 AS lvl,
        terr_id AS root_id,
        terr_name AS path
    FROM
        geo_view
    WHERE
        terr_over IS NULL
    UNION ALL
  -- Recursive member.
     SELECT
        t2.terr_id,
        t2.terr_name,
        t2.terr_over,
        lvl + 1,
        t1.root_id,
        t1.path
         || '->'
         || t2.terr_name AS path
    FROM
        geo_view t2,
        t1
    WHERE
        t2.terr_over = t1.terr_id
) SELECT
    terr_name,
    path,
    chld.subnodes,
        CASE lvl
            WHEN 1   THEN 'Root'
            WHEN 4   THEN 'Leaf'
            ELSE 'Branch'
        END
    AS node_type
FROM
    t1
    JOIN (
        SELECT
            the_root,
            COUNT(*) - 1 AS subnodes
        FROM
            (
                SELECT
                    CONNECT_BY_ROOT ( geo_view.terr_id ) AS the_root
                FROM
                    geo_view
                CONNECT BY
                    PRIOR terr_id = terr_over
            )
        GROUP BY
            the_root
    ) chld ON t1.terr_id = chld.the_root;