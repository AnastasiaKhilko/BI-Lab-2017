CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_passengers
AS
  /**===============================================*\
  Name...............:   pkg_etl_dim_passengers
  Contents...........:   Load data of passenger entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_dim
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO dim_passengers tgt USING
  (SELECT passenger_id,
    passenger_code,
    give_name AS given_name,
    middle_name,
    last_name,
    city,
    country_abbr,
    email,
    phone,
    birthday
  FROM cls_dim_passengers
  MINUS
  SELECT passenger_id,
    passenger_code,
    given_name,
    middle_name,
    last_name,
    city,
    country_abbr,
    email,
    phone,
    birthday
  FROM dim_passengers
  ) src ON (src.passenger_code = tgt.passenger_code)
WHEN MATCHED THEN
  UPDATE
  SET tgt.given_name = src.given_name,
    tgt.middle_name  = src.middle_name,
    tgt.last_name    = src.last_name,
    tgt.city         = src.city,
    tgt.country_abbr = src.country_abbr,
    tgt.email        = src.email,
    tgt.phone        = src.phone,
    tgt.birthday     = src.birthday,
    tgt.update_dt    = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      passenger_surr_id,
      passenger_id,
      passenger_code,
      given_name,
      middle_name,
      last_name,
      city,
      country_abbr,
      email,
      phone,
      birthday,
      insert_dt,
      update_dt
    )
    VALUES
    (
      dim_passenger_seq.nextval,
      src.passenger_id,
      src.passenger_code,
      src.given_name,
      src.middle_name,
      src.last_name,
      src.city,
      src.country_abbr,
      src.email,
      src.phone,
      src.birthday,
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_dim;
END pkg_etl_dim_passengers;