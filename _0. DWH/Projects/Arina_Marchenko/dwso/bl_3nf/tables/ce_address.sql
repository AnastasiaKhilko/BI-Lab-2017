DROP sequence seq_address;
CREATE SEQUENCE seq_address INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_address CASCADE CONSTRAINTS;
  CREATE TABLE ce_address
    (
      address_id   NUMBER(6) NOT NULL,
      address_name VARCHAR2(200) NOT NULL,
      city_id      NUMBER(6) NOT NULL,
      update_dt    DATE NOT NULL
    );
  GRANT SELECT ON bl_3nf.seq_address TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_address TO bl_cl;
  ALTER TABLE ce_address ADD CONSTRAINT ce_address_pk PRIMARY KEY (address_id);
  ALTER TABLE ce_address ADD CONSTRAINT fk_ce_city_add FOREIGN KEY (city_id) REFERENCES ce_city(city_id);
