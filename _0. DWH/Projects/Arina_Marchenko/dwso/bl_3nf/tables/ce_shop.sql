DROP sequence seq_shop;
CREATE SEQUENCE seq_shop INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_shop CASCADE CONSTRAINTS;
  CREATE TABLE ce_shop
    (
      shop_id    NUMBER(6) NOT NULL,
      shop_code  NUMBER(6) NOT NULL,
      shop_name  VARCHAR2(200) NOT NULL,
      phone      VARCHAR2(200) NOT NULL,
      email      VARCHAR2(200) NOT NULL,
      address_id NUMBER(6) NOT NULL,
      update_dt  DATE NOT NULL
    );
  GRANT
  SELECT ON bl_3nf.seq_shop TO bl_cl;
  GRANT
  SELECT,
  INSERT,
  DELETE,
  UPDATE ON ce_shop TO bl_cl;
  ALTER TABLE ce_shop ADD CONSTRAINT ce_shop_pk PRIMARY KEY (shop_id);
  ALTER TABLE ce_shop ADD CONSTRAINT fk_ce_address FOREIGN KEY (address_id) 
  REFERENCES ce_address(address_id);
    GRANT SELECT ON ce_shop to bl_cl_dm;
