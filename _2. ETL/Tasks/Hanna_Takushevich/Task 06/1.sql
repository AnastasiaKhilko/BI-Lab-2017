CREATE OR REPLACE PACKAGE pkg_etl_dim_airports AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_airports
  Contents...........:   Load data of airport entity
  Author.............:   Hanna Takushevich
  Date...............:   03-12-2017
  \*=============================================== */
  /**

  /**
  * Load data to dim table
  */
  PROCEDURE load_to_dim;
  
END pkg_etl_dim_airports;


CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_airports
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_airports
  Contents...........:   Load data of airport entity
  Author.............:   Hanna Takushevich
  Date...............:   03-12-2017
  \*=============================================== */
PROCEDURE load_to_dim
IS
TYPE airport_id_type
IS
  TABLE OF NUMBER INDEX BY PLS_INTEGER;
  airports_ids airport_id_type;
  airports_ids_for_update airport_id_type;
  airports_ids_for_insert airport_id_type;
  v_count NUMBER;
BEGIN
  SELECT airport_id BULK COLLECT
  INTO airports_ids
  FROM
    (SELECT airport_id,
      city_id,
      airport_name,
      airport_iata,
      airport_icao,
      airport_faa,
      city_name,
      country_name,
      subregion_name,
      region_name
    FROM cls_dim_airports
    MINUS
    SELECT airport_id,
      city_id,
      airport_name,
      airport_iata,
      airport_icao,
      airport_faa,
      city_name,
      country_name,
      subregion_name,
      region_name
    FROM dim_airports
    );
  FOR indx IN 1 .. airports_ids.COUNT
  LOOP
    SELECT COUNT(airport_id)
    INTO v_count
    FROM dim_airports
    WHERE airport_id                                             = airports_ids(indx);
    IF v_count                                                   = 1 THEN
      airports_ids_for_update (airports_ids_for_update.COUNT + 1) := airports_ids (indx);
    ELSIF v_count                                                =0 THEN
      airports_ids_for_insert (airports_ids_for_insert.COUNT + 1) := airports_ids (indx);
    END IF;
  END LOOP;
  FORALL indx IN 1 .. airports_ids_for_update.COUNT
  UPDATE dim_airports
  SET airport_name =
    (SELECT airport_name
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    airport_iata =
    (SELECT airport_iata
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    airport_icao =
    (SELECT airport_icao
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    airport_faa =
    (SELECT airport_faa
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    country_name =
    (SELECT country_name
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    subregion_name =
    (SELECT subregion_name
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    region_name =
    (SELECT region_name
    FROM cls_dim_airports
    WHERE airport_id = airports_ids(indx)
    ),
    update_dt      = sysdate
  WHERE airport_id = airports_ids(indx);
  FORALL indx IN 1 .. airports_ids_for_insert.COUNT
  INSERT INTO dim_airports
  SELECT dim_airport_seq.nextval,
    cd.airport_id,
    cd.city_id,
    cd.airport_name,
    cd.airport_iata,
    cd.airport_icao,
    cd.airport_faa,
    cd.city_name,
    cd.country_name,
    cd.subregion_name,
    cd.region_name,
    sysdate,
    sysdate
  FROM cls_dim_airports cd
  WHERE airport_id = airports_ids(indx);
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_dim;
END pkg_etl_dim_airports;