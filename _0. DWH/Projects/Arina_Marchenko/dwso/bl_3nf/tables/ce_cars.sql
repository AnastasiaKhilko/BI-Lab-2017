DROP sequence seq_cars;
CREATE SEQUENCE seq_cars INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_cars CASCADE CONSTRAINTS;
  CREATE TABLE ce_cars
    (
      car_id             NUMBER(8) NOT NULL,
      car_number         VARCHAR2(500) NOT NULL,
      car_name           VARCHAR2(500) NOT NULL ,
      vehicle_type_id    NUMBER(8) NOT NULL,
      engine_type_id     NUMBER(6) NOT NULL,
      gearbox_type_id    NUMBER(6) NOT NULL,
      model_id           NUMBER(6) NOT NULL,
      repaired_status_id NUMBER(6) NOT NULL,
      start_dt           DATE NOT NULL,
      end_dt             DATE NOT NULL
    );
  ALTER TABLE ce_cars ADD CONSTRAINT ce_cars_pk PRIMARY KEY (car_id);
  ALTER TABLE ce_cars ADD CONSTRAINT fk_ce_vehicle_type FOREIGN KEY (vehicle_type_id) REFERENCES ce_vehicle_type(vehicle_type_id);
  ALTER TABLE ce_cars ADD CONSTRAINT fk_ce_engine_type FOREIGN KEY (engine_type_id) REFERENCES ce_engine_type(engine_type_id);
  ALTER TABLE ce_cars ADD CONSTRAINT fk_ce_gearbox_type FOREIGN KEY (gearbox_type_id) REFERENCES ce_gearbox_type(gearbox_type_id);
  ALTER TABLE ce_cars ADD CONSTRAINT fk_ce_model FOREIGN KEY (model_id) REFERENCES ce_model(model_id);
  ALTER TABLE ce_cars ADD CONSTRAINT fk_ce_repaired_status FOREIGN KEY (repaired_status_id) REFERENCES ce_repaired_status(repaired_status_id);
  GRANT SELECT ON bl_3nf.seq_cars TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_cars TO bl_cl;
  GRANT SELECT ON ce_cars to bl_cl_dm;