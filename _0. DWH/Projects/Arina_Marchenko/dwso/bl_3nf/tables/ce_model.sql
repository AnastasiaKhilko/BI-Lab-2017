DROP sequence seq_model;
CREATE SEQUENCE seq_model INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_model CASCADE CONSTRAINTS;
  CREATE TABLE ce_model
    (
      model_id   NUMBER(6) NOT NULL,
      model_name VARCHAR2(200) NOT NULL,
      brand_id   NUMBER(6) NOT NULL,
      update_dt  DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_model TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_model TO bl_cl;
  ALTER TABLE ce_model ADD CONSTRAINT ce_model_pk PRIMARY KEY (model_id);
  ALTER TABLE ce_model ADD CONSTRAINT fk_ce_brand FOREIGN KEY (brand_id) REFERENCES ce_brand(brand_id);
