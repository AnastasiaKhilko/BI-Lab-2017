CREATE SEQUENCE cust_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE tmp_customers (
    cust_id      NUMBER PRIMARY KEY,
    first_name   VARCHAR2(30),
    last_name    VARCHAR2(30),
    geo_desc     VARCHAR2(300),
    cust_sex     VARCHAR2(1)
);

INSERT INTO tmp_customers SELECT
    cust_seq.NEXTVAL,
    cust.first_name,
    cust.last_name,
    cntr.geo_desc,
    cust.sex
FROM
    (
        SELECT --+no_merge
            e2.first_name,
            e1.last_name,
            round(dbms_random.value(
                (
                    SELECT
                        MIN(geo_id)
                    FROM
                        tmp_geo
                ),
                (
                    SELECT
                        MAX(geo_id)
                    FROM
                        tmp_geo
                )
            ) ) AS geo_id,
            DECODE(
                round(dbms_random.value),
                0,
                'M',
                1,
                'F'
            ) AS sex
        FROM
            hr.employees e1,
            hr.employees e2,
            (
                SELECT
                    level
                FROM
                    dual
                CONNECT BY
                    level <= 10
            )
    ) cust,
    (
        SELECT
            geo_id rn,
            city_name
             || ','
             || country_name AS geo_desc
        FROM
            tmp_geo
    ) cntr
WHERE
    cust.geo_id = cntr.rn;

COMMIT;