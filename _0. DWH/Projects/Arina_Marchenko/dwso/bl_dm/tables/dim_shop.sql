DROP sequence seq_shop_dim;
CREATE SEQUENCE seq_shop_dim INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE dim_shop CASCADE CONSTRAINTS;
  CREATE TABLE dim_shop
    (
	  shop_did    NUMBER(6) NOT NULL,
      shop_id    NUMBER(6) NOT NULL,
      shop_code  NUMBER(6) NOT NULL,
      shop_name  VARCHAR2(200) NOT NULL,
      phone      VARCHAR2(200) NOT NULL,
      email      VARCHAR2(200) NOT NULL,
      address_name VARCHAR(200) NOT NULL,
	  city_name VARCHAR(200) NOT NULL,
	  country_name VARCHAR(200) NOT NULL,
      update_dt  DATE NOT NULL
    );
  GRANT SELECT ON bl_dm.seq_shop_dim TO bl_cl_dm;
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_shop TO bl_cl_dm;
  ALTER TABLE dim_shop ADD CONSTRAINT dim_shop_pk PRIMARY KEY (shop_did);