TRUNCATE TABLE cl_pilot;
INSERT INTO cl_pilot
SELECT pl.pilot_id AS pilot_id,
  pl.national_id   AS national_id,
  pl.name          AS p_name,
  pl.surname       AS surname,
  pl.gender        AS gender,
  pl.age           AS age,
  pl.hours_in_air  AS hours_in_air,
  pl.begin_date    AS begin_date,
  pl.end_date      AS end_date 
FROM
  (SELECT DISTINCT pilot_id,
    national_id,
    name,
    surname,
    gender,
    age,
    hours_in_air,
    begin_date,
    end_date
  FROM wrk_pilot
  ) pl
WHERE pilot_id   IS NOT NULL
AND national_id  IS NOT NULL
AND name         IS NOT NULL
AND surname      IS NOT NULL
AND gender       IS NOT NULL
AND age          IS NOT NULL
AND hours_in_air IS NOT NULL
and begin_date IS NOT NULL
AND end_date IS NOT NULL;
