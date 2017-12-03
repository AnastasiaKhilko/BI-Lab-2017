DROP sequence seq_gearbox_type;
CREATE SEQUENCE seq_gearbox_type INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_gearbox_type CASCADE CONSTRAINTS;
  CREATE TABLE ce_gearbox_type
    (
      gearbox_type_id   NUMBER(6) NOT NULL,
      gearbox_type_name VARCHAR2(200) NOT NULL,
      update_dt         DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_gearbox_type TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_gearbox_type TO bl_cl;
  ALTER TABLE ce_gearbox_type ADD CONSTRAINT ce_gearbox_type_pk PRIMARY KEY (gearbox_type_id);