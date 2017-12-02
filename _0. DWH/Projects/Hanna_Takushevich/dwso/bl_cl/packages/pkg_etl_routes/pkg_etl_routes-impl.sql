CREATE OR REPLACE PACKAGE BODY pkg_etl_routes
AS
  /**===============================================*\
  Name...............:   pkg_etl_routes
  Contents...........:   Load data of route entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_routes';
  INSERT INTO wrk_routes
  SELECT * FROM ext_routes;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_routes';
  INSERT INTO cls_routes
  SELECT trim(BOTH '"'
  FROM route_code),
    trim(BOTH '"'
  FROM airport_name_from) ,
    trim(BOTH '"'
  FROM airport_name_to)
  FROM wrk_routes COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;
PROCEDURE load_to_3nf
IS
BEGIN
  MERGE INTO ce_routes sr USING
  ( SELECT route_code, airport_name_from, airport_name_to FROM cls_routes
  MINUS
  SELECT route_code,
    (SELECT airport_name
    FROM ce_airports
    WHERE airport_from_id = ce.airport_from_id
    AND rownum            =1
    ),
    (SELECT airport_name
    FROM ce_airports
    WHERE airport_to_id = ce.airport_to_id
    AND rownum          =1
    )
  FROM ce_routes ce
  ) cls ON ( cls.route_code = sr.route_code )
WHEN MATCHED THEN
  UPDATE
  SET sr.airport_from_id =
    (SELECT airport_id
    FROM ce_airports
    WHERE airport_name = cls.airport_name_from
    AND rownum         =1
    ),
    sr.airport_to_id =
    (SELECT airport_id
    FROM ce_airports
    WHERE airport_name = cls.airport_name_to
    AND rownum         =1
    ), update_dt = sysdate WHEN NOT MATCHED THEN
  INSERT
    (
      route_id,
      route_code,
      airport_from_id,
      airport_to_id,
      insert_dt,
      update_dt
    )
    VALUES
    (
      route_seq.nextval ,
      cls.route_code,
      (SELECT airport_id
      FROM ce_airports
      WHERE airport_name = cls.airport_name_from
      AND rownum         =1
      ),
      (SELECT airport_id
      FROM ce_airports
      WHERE airport_name = cls.airport_name_to
      AND rownum         =1
      ),
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_routes;