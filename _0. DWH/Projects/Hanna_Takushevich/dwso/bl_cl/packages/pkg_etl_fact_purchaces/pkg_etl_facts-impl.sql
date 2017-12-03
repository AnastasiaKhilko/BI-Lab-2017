alter session enable parallel dml;
CREATE OR REPLACE PACKAGE BODY pkg_etl_facts
AS
  /**===============================================*\
  Name...............:   pkg_etl_regions
  Contents...........:   Load data of region entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */

  
PROCEDURE load_to_fact
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO fact_purchaces r USING
  ( SELECT /*+ parallel(cfp 4) */ purchace_id, (select flight_surr_id from dim_flights where flight_id=cfp.flight_id) as flight_surr_id, (select passenger_surr_id from dim_passengers where passenger_id=cfp.passenger_id) as passenger_surr_id, (select airline_surr_id from dim_airlines where airline_id=cfp.airline_id) airline_surr_id, (select service_class_surr_id from dim_service_classes_scd where service_class_id=cfp.service_class_id) as service_class_surr_id, purchace_date, (select airport_surr_id from dim_airports where airport_id=cfp.airport_to_id) as airport_to_surr_id, (select airport_surr_id from dim_airports where airport_id=cfp.airport_from_id) as airport_from_surr_id, price FROM cls_fact_purchaces cfp
  MINUS
  SELECT /*+ parallel( fp 4) */ purchace_id, flight_surr_id, passenger_surr_id, airline_surr_id, service_class_surr_id, purchace_date, airport_to_surr_id, airport_from_surr_id,price  FROM fact_purchaces  fp
  ) cls ON ( cls.purchace_id = r.purchace_id )
WHEN MATCHED THEN
  UPDATE SET r.price = cls.price WHEN NOT MATCHED THEN
  INSERT
    (
      purchace_id,
      flight_surr_id,
      passenger_surr_id,
      airline_surr_id,
      service_class_surr_id,
      purchace_date,
      airport_to_surr_id,
      airport_from_surr_id,
      price
    )
    VALUES
    (
      cls.purchace_id,
      cls.flight_surr_id,
      cls.passenger_surr_id,
      cls.airline_surr_id,
      cls.service_class_surr_id,
      to_date(cls.purchace_date, 'dd-mon-yy'),
      cls.airport_to_surr_id,
      cls.airport_from_surr_id,
      cls.price
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_fact;
END pkg_etl_facts;