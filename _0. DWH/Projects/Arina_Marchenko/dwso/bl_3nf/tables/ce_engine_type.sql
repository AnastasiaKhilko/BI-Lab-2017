DROP sequence seq_engine_type;
CREATE SEQUENCE seq_engine_type INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_engine_type CASCADE CONSTRAINTS;
  CREATE TABLE ce_engine_type
    (
      engine_type_id   NUMBER(6) NOT NULL,
      engine_type_name VARCHAR2(200) NOT NULL,
      update_dt        DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_engine_type TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_engine_type TO bl_cl;
  ALTER TABLE ce_engine_type ADD CONSTRAINT ce_engine_type_pk PRIMARY KEY (engine_type_id);