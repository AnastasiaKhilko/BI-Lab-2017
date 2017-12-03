DROP sequence seq_customers_dim;
CREATE SEQUENCE seq_customers_dim INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE dim_customers CASCADE CONSTRAINTS;
  CREATE TABLE dim_customers
    (
	  customer_did  NUMBER ( 38 ) NOT NULL,
      customer_id   NUMBER ( 38 ) NOT NULL,
      customer_code NUMBER ( 38 ) NOT NULL,
      name          VARCHAR2 ( 200 ) NOT NULL,
      surname       VARCHAR2 ( 200 ) NOT NULL,
      age           NUMBER(6) NOT NULL,
      gender        VARCHAR2 ( 200 ) NOT NULL,
      phone         VARCHAR2(200) NOT NULL,
      email         VARCHAR2(200) NOT NULL,
      update_dt     DATE NOT NULL
    );
  GRANT SELECT ON bl_dm.seq_customers_dim TO bl_cl_dm;
  GRANT SELECT, INSERT, DELETE, UPDATE ON dim_customers TO bl_cl_dm;
  ALTER TABLE dim_customers ADD CONSTRAINT dim_customers_pk PRIMARY KEY (customer_did);