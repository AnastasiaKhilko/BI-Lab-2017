CREATE TABLE tmp_airline (
    airline_id       NUMBER PRIMARY KEY,
    airline_geo_id   NUMBER,
    airline_iata     VARCHAR2(2),
    airline_icao     VARCHAR2(3),
    airline_name     VARCHAR2(50),
    CONSTRAINT fk_airline_geo FOREIGN KEY ( airline_geo_id )
        REFERENCES tmp_geo ( geo_id )
);

INSERT INTO tmp_airline SELECT
    n AS airline_id,
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
    ) ) AS airline_geo_id,
        CASE round(dbms_random.value(
            -0.4,
            2.5
        ) )
            WHEN 0   THEN substr(ROWNUM,1,1)
             || dbms_random.string('u',1)
            WHEN 1   THEN dbms_random.string('u',1)
             || substr(ROWNUM,1,1)
            WHEN 2   THEN dbms_random.string('u',2)
        END
    AS airline_iata,
    chr(floor( (n - 1) / 676) + 65)
     || chr(mod(
        floor( (n - 1) / 26),
        26
    ) + 65)
     || chr(65 + mod(n - 1,26) ) AS airline_icao,
    'Airline name ' || n AS airline_name
FROM
    (
        SELECT
            level n
        FROM
            dual
        CONNECT BY
            level <= 100
    );

COMMIT;