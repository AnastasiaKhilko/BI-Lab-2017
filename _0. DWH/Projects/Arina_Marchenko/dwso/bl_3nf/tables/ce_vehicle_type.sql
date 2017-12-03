DROP sequence seq_vehicle_type;
CREATE SEQUENCE seq_vehicle_type INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_vehicle_type CASCADE CONSTRAINTS;
  CREATE TABLE ce_vehicle_type
    (
      vehicle_type_id   NUMBER(6) NOT NULL,
      vehicle_type_name VARCHAR2(200) NOT NULL,
      update_dt         DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_vehicle_type TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_vehicle_type TO bl_cl;
  ALTER TABLE ce_vehicle_type ADD CONSTRAINT ce_vehicle_type_pk PRIMARY KEY (vehicle_type_id);