DROP sequence seq_seller;
CREATE SEQUENCE seq_seller INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_seller CASCADE CONSTRAINTS;
  CREATE TABLE ce_seller
    (
      seller_id   NUMBER(6) NOT NULL,
      seller_code NUMBER(6) NOT NULL,
      name        VARCHAR2(200) NOT NULL,
      surname     VARCHAR2(200) NOT NULL,
      phone       VARCHAR2(200) NOT NULL,
      email       VARCHAR2(200) NOT NULL,
      city_id     NUMBER(6) NOT NULL,
      update_dt   DATE NOT NULL
    );
		
  GRANT SELECT ON bl_3nf.seq_seller TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_seller TO bl_cl;
  ALTER TABLE ce_seller ADD CONSTRAINT ce_seller_pk PRIMARY KEY (seller_id);
  ALTER TABLE ce_seller ADD CONSTRAINT fk_ce_city FOREIGN KEY (city_id) REFERENCES ce_city(city_id);
    GRANT SELECT ON ce_seller to bl_cl_dm;
