DROP TABLE cl_cars;
CREATE TABLE cl_cars
  (
	car_number         VARCHAR2(500) NOT NULL ,
    car_name           VARCHAR2(500) NOT NULL ,
    vehicle_type_id    NUMBER(8) NOT NULL,
    engine_type_id     NUMBER(6) NOT NULL,
    gearbox_type_id    NUMBER(6) NOT NULL,
    model_id           NUMBER(6) NOT NULL,
    repaired_status_id NUMBER(6) NOT NULL,
    start_dt           DATE NOT NULL,
    end_dt             DATE NOT NULL
  );
GRANT SELECT ON cl_cars TO bl_3nf;