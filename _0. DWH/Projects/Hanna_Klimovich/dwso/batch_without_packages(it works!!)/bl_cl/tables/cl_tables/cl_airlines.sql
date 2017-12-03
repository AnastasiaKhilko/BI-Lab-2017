TRUNCATE TABLE cl_airlines;

INSERT INTO cl_airlines
SELECT DISTINCT air.Airline_ID AS airline_id,
  air.name          AS a_name,
  air.ICAO            AS ICAO,
  air.Active          AS ACTIVE

FROM
  (SELECT DISTINCT Airline_ID , name , ICAO , Active FROM wrk_airlines
  ) air
WHERE Airline_ID IS NOT NULL
AND name       IS NOT NULL
AND ICAO         IS NOT NULL 
AND ICAO != '0' 
AND Active       IS NOT NULL ;