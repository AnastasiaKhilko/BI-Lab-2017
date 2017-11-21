SELECT
    terr_name,
    sys_connect_by_path(terr_name,'->') "Hierarchy",
    chld.subnodes AS count_children,
        CASE CONNECT_BY_ISLEAF
            WHEN 1   THEN 'Leaf'
            WHEN 0   THEN (
                CASE level
                    WHEN 1   THEN 'Root'
                    ELSE 'Branch'
                END
            )
        END
    AS node_type
FROM
    geo_view geo
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
    ) chld ON geo.terr_id = chld.the_root
START WITH
    terr_over IS NULL
CONNECT BY
    PRIOR terr_id = terr_over;