CREATE OR REPLACE PACKAGE BODY pkg_etl_payments
AS
  /**===============================================*\
  Name...............:   pkg_etl_payments
  Contents...........:   Load data of payment entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_payments';
  INSERT INTO wrk_payments
  SELECT * FROM ext_payments;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_payments';
  INSERT INTO cls_payments
  SELECT trim(both '"'
  FROM payment_code),
    trim(both '"'
  FROM service_class_name),
    trim(both '"'
  FROM route_code),
    to_number(SUBSTR(price,1, instr(price, chr(13))-2))
  FROM wrk_payments COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  MERGE INTO ce_payments sr USING
  ( SELECT payment_code, service_class_name, route_code, price FROM cls_payments
  MINUS
  SELECT payment_code,
    (SELECT DISTINCT class_name
    FROM ce_service_classes
    WHERE class_id = ce.service_class_id
    ),
    (SELECT route_code FROM ce_routes WHERE route_id = ce.route_id
    ),
    price
  FROM ce_payments ce
  ) cls ON ( cls.payment_code = sr.payment_code )
WHEN MATCHED THEN
  UPDATE
  SET sr.service_class_id =
    (SELECT class_id
    FROM ce_service_classes
    WHERE service_class_name = cls.service_class_name
    ),
    sr.route_id =
    (SELECT route_id FROM ce_routes WHERE route_code = cls.route_code
    ),
    price     = cls.price,
    update_dt = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      payment_id,
      payment_code,
      service_class_id,
      route_id,
      price
    )
    VALUES
    (
      payment_seq.nextval ,
      cls.payment_code,
      (SELECT class_id
      FROM ce_service_classes f
      WHERE f.class_name = cls.service_class_name
      ),
      (SELECT route_id FROM ce_routes WHERE route_code = cls.route_code
      ),
      cls.price
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_payments;