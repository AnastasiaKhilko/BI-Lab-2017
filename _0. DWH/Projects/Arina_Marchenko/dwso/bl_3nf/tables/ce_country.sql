DROP sequence seq_country;
CREATE SEQUENCE seq_country INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_country CASCADE CONSTRAINTS;
  CREATE TABLE ce_country
    (
      country_id   NUMBER(6) NOT NULL,
      country_name VARCHAR2(200) NOT NULL,
      update_dt    DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_country TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_country TO bl_cl;
  ALTER TABLE ce_country ADD CONSTRAINT ce_country_pk PRIMARY KEY (country_id);