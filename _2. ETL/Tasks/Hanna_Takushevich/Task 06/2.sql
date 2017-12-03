CREATE OR REPLACE PACKAGE pkg_etl_dim_airlines AUTHID CURRENT_USER
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_airlines
  Contents...........:   Load data of airline entity
  Author.............:   Hanna Takushevich
  Date...............:   30-11-2017
  \*=============================================== */
  /**

  /**
  * Load data to dim table
  */
PROCEDURE load_to_dim;
  
END pkg_etl_dim_airlines;


CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_airlines
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_airlines
  Contents...........:   Load data of airline entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_dim
IS
  v_count NUMBER;
  CURSOR c1
  IS
    SELECT airline_id,
      airline_name,
      icao_codes,
      iata_codes,
      airline_country
    FROM cls_dim_airlines;
BEGIN
  FOR airline_rec IN c1
  LOOP
    SELECT COUNT(airline_id)
    INTO v_count
    FROM dim_airlines
    WHERE airline_id = airline_rec.airline_id;
    IF v_count       = 1 THEN
      UPDATE dim_airlines
      SET airline_name  = airline_rec.airline_name,
        airline_icao    = airline_rec.icao_codes,
        airline_iata    = airline_rec.iata_codes,
        airline_country = airline_rec.airline_country,
        update_dt       = sysdate;
    elsif v_count       = 0 THEN
      INSERT INTO dim_airlines
      SELECT dim_airline_seq.nextval,
        airline_rec.airline_id,
        airline_rec.airline_name,
        airline_rec.iata_codes,
        airline_rec.iata_codes,
        airline_rec.airline_country,
        sysdate,
        sysdate
      FROM dual;
    END IF;
  END LOOP;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_dim;
END pkg_etl_dim_airlines;