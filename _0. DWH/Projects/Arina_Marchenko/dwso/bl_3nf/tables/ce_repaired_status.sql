DROP sequence seq_repaired_status;
CREATE SEQUENCE seq_repaired_status INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_repaired_status CASCADE CONSTRAINTS;
  CREATE TABLE ce_repaired_status
    (
      repaired_status_id   NUMBER(6) NOT NULL,
      repaired_status_name VARCHAR2(200) NOT NULL,
      update_dt            DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_repaired_status TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_repaired_status TO bl_cl;
  ALTER TABLE ce_repaired_status ADD CONSTRAINT ce_repaired_status_pk PRIMARY KEY (repaired_status_id);