  DROP TABLE cl_dim_cars CASCADE CONSTRAINTS;
  CREATE TABLE cl_dim_cars
    (
      car_id             NUMBER(8) NOT NULL,
      car_number         VARCHAR2(500) NOT NULL,
      car_name           VARCHAR2(500) NOT NULL ,
      vehicle_type_name  VARCHAR2(500) NOT NULL,
      engine_type_name   VARCHAR2(500) NOT NULL,
      gearbox_type_name  VARCHAR2(500) NOT NULL,
      model              VARCHAR2(500) NOT NULL,
      repaired_status_name VARCHAR2(500) NOT NULL,
      start_dt           DATE NOT NULL,
      end_dt             DATE NOT NULL
    );
  GRANT SELECT ON cl_dim_cars TO bl_dm;