DROP sequence seq_seller_dim;
CREATE SEQUENCE seq_seller_dim INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE dim_seller CASCADE CONSTRAINTS;
  CREATE TABLE dim_seller
    (
	  seller_did  NUMBER(6) NOT NULL,
      seller_id   NUMBER(6) NOT NULL,
      seller_code NUMBER(6) NOT NULL,
      name        VARCHAR2(200) NOT NULL,
      surname     VARCHAR2(200) NOT NULL,
      phone       VARCHAR2(200) NOT NULL,
      email       VARCHAR2(200) NOT NULL,
      city_name     VARCHAR2(200) NOT NULL,
	  country_name     VARCHAR2(200) NOT NULL,
      update_dt   DATE NOT NULL
    );
		
  GRANT SELECT ON bl_dm.seq_seller_dim TO bl_cl_dm;
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_seller TO bl_cl_dm;
  
  ALTER TABLE dim_seller ADD CONSTRAINT dim_seller_pk PRIMARY KEY (seller_did);
