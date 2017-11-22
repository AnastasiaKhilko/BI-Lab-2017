CREATE OR REPLACE VIEW geo_with AS
    WITH hier (
        child_id,
        description,
        lvl,
        parent_id,
        path,
        root,
        branch,
        leaf,
        "Count of Children"
    ) AS (
        SELECT
            child_id,
            description,
            0 AS lvl,
            parent_id,
            description AS path,
            'Y' AS root,
            'N' AS branch,
            'N' AS leaf,
            (
                SELECT
                    COUNT(*) - 1
                FROM
                    geo
                START WITH
                    parent_id IS NULL
                CONNECT BY
                    PRIOR child_id = parent_id
            ) AS chl
        FROM
            geo
        WHERE
            parent_id IS NULL
        UNION ALL
        SELECT
            chld.child_id,
            chld.description,
            prnt.lvl + 1,
            chld.parent_id,
            prnt.path
             || '==>'
             || chld.description,
            'N',
            (
                CASE
                    WHEN (
                        SELECT
                            COUNT(*)
                        FROM
                            geo
                        WHERE
                            parent_id = chld.child_id
                    ) <> 0 THEN 'Y'
                    ELSE 'N'
                END
            ) AS branch,
            (
                CASE
                    WHEN (
                        SELECT
                            COUNT(*)
                        FROM
                            geo
                        WHERE
                            parent_id = chld.child_id
                    ) = 0 THEN 'Y'
                    ELSE 'N'
                END
            ) AS leaf,
            (
                SELECT
                    COUNT(*)
                FROM
                    geo
                START WITH
                    parent_id = chld.child_id
                CONNECT BY
                    PRIOR child_id = parent_id
            ) AS chl
        FROM
            geo chld
            JOIN hier prnt ON chld.parent_id = prnt.child_id
    )
        SEARCH DEPTH FIRST BY description SET q
    SELECT
        child_id,
        description,
        parent_id,
        path,
        root,
        branch,
        leaf,
        "Count of Children"
    FROM
        hier
    ORDER BY q;