CREATE OR REPLACE PACKAGE BODY pkg_etl_purchaces
AS
  /**===============================================*\
  Name...............:   pkg_etl_regions
  Contents...........:   Load data of region entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_regions';
  INSERT INTO cls_purchaces
  SELECT ROUND(dbms_random.value(
    (SELECT MIN(flight_id) FROM ce_flights
    ),
    (SELECT MAX(flight_id) FROM ce_flights
    ))) AS fl_id,
    ROUND(dbms_random.value(
    (SELECT MIN(payment_id) FROM ce_payments
    ),
    (SELECT MAX(payment_id) FROM ce_payments
    ))) pay_id,
    ROUND(dbms_random.value(
    (SELECT MIN(passenger_id) FROM ce_passengers
    ),
    (SELECT MAX(passenger_id) FROM ce_passengers
    ))) AS pas_id,
    sysdate - dbms_random.value(0, 1300)
  FROM
    ( SELECT level n FROM dual CONNECT BY level <= 1000000
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  INSERT
  INTO ce_purchaces
    (
      purchace_id,
      flight_id,
      payment_id,
      passenger_id,
      purchace_date
    )
  SELECT purchace_seq.nextval,
    flight_id,
    payment_id,
    passenger_id,
    purchace_date
  FROM
    (SELECT flight_id, payment_id, passenger_id, purchace_date FROM cls_purchaces
    MINUS
    SELECT flight_id, payment_id, passenger_id, purchace_date FROM ce_purchaces
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_purchaces;