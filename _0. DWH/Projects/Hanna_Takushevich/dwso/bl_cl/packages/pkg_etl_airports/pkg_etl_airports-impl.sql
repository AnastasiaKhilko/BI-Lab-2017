CREATE OR REPLACE PACKAGE BODY pkg_etl_airports
AS
  /**===============================================*\
  Name...............:   pkg_etl_airports
  Contents...........:   Load data of airport entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_airports';
  INSERT INTO wrk_airports
  SELECT airport_name,
    airport_city,
    airport_country,
    airport_iata,
    airport_icao,
    airport_faa
  FROM ext_airports;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_airports';
  INSERT INTO cls_airports
  SELECT airport_name,
    airport_city,
    airport_country,
    airport_iata,
    airport_icao,
    CASE airport_faa
      WHEN chr(13)
      THEN NULL
      ELSE airport_faa
    END
  FROM wrk_airports COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_airports p USING
  (SELECT z.airport_name,
    z.airport_iata,
    z.airport_icao,
    z.airport_faa,
    z.airport_city,
    airport_country
  FROM
    (SELECT airport_name,
      airport_iata,
      airport_icao,
      airport_faa,
      airport_city
    FROM cls_airports
    MINUS
    SELECT airport_name,
      airport_iata,
      airport_icao,
      airport_faa,
      (SELECT city_name FROM ce_cities WHERE city_id = ce_airports.city_id
      )
    FROM ce_airports
    ) z
  JOIN cls_airports
  ON cls_airports.airport_name = z.airport_name
  ) cls ON ( cls.airport_name  = p.airport_name )
WHEN MATCHED THEN
  UPDATE
  SET p.airport_iata = cls.airport_iata,
    p.airport_icao   = cls.airport_icao,
    p.airport_faa    = cls.airport_faa,
    p.city_id        =
    (SELECT city_id
    FROM ce_cities
    JOIN ce_countries
    ON ce_cities.country_id=ce_countries.country_id
    WHERE city_name        = cls.airport_city
    AND country_name       = cls.airport_country
    ),
    p.update_dt = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      airport_id,
      airport_name,
      city_id,
      airport_iata,
      airport_icao,
      airport_faa,
      insert_dt,
      update_dt
    )
    VALUES
    (
      airport_seq.nextval ,
      cls.airport_name,
      to_number(
      (SELECT city_id
      FROM ce_cities
      JOIN ce_countries
      ON ce_cities.country_id=ce_countries.country_id
      WHERE city_name        = cls.airport_city
      AND country_name       = cls.airport_country
      )),
      cls.airport_iata,
      cls.airport_icao,
      cls.airport_faa,
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_airports;