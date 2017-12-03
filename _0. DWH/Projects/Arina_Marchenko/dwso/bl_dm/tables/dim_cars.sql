DROP sequence seq_cars_dim;
CREATE SEQUENCE seq_cars_dim INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE dim_cars CASCADE CONSTRAINTS;
  CREATE TABLE dim_cars
    (
	  car_did             NUMBER(8) NOT NULL,
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
  ALTER TABLE dim_cars ADD CONSTRAINT dim_cars_pk PRIMARY KEY (car_did);
  GRANT SELECT ON bl_dm.seq_cars_dim TO bl_cl_dm;
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_cars TO bl_cl_dm;