CREATE OR REPLACE VIEW geo_connect_by AS
    SELECT
        g.child_id,
        g.description,
        g.parent_id,
        ltrim(
            sys_connect_by_path(description,'==>'),
            '==>'
        ) AS path,
        (
            CASE
                WHEN level = 1   THEN 'Y'
                ELSE 'N'
            END
        ) AS root,
        (
            CASE
                WHEN
                    level <> 1
                AND
                    CONNECT_BY_ISLEAF = 0
                THEN 'Y'
                ELSE 'N'
            END
        ) AS branch,
        (
            CASE
                WHEN CONNECT_BY_ISLEAF = 1   THEN 'Y'
                ELSE 'N'
            END
        ) AS leaf,
        (
            SELECT
                COUNT(*)
            FROM
                geo
            START WITH
                parent_id = g.child_id
            CONNECT BY
                PRIOR child_id = parent_id
        ) AS "Count of Children"
    FROM
        geo g
    START WITH
        parent_id IS NULL
    CONNECT BY
        PRIOR child_id = parent_id
    ORDER SIBLINGS BY 2;
