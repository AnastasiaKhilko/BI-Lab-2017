TRUNCATE TABLE cl_PLANE;
INSERT INTO cl_plane
SELECT pln.ssd_name AS MODEL_NAME,
  pln.manufacturer    AS MANUFACTURER,
  pln.long_name       AS LONG_NAME ,
  pln.short_name      AS SHORT_NAME,
  pln.begin_date      AS BEGIN_DATE,
  pln.end_date        AS END_DATE
FROM
  (SELECT DISTINCT ssd_name ,
    manufacturer ,
    long_name ,
    short_name,
    begin_date ,
    end_date
  FROM wrk_plane
  ) pln
WHERE ssd_name IS NOT NULL
AND manufacturer IS NOT NULL
AND long_name    IS NOT NULL
AND short_name   IS NOT NULL
AND begin_date   IS NOT NULL
AND end_date     IS NOT NULL;