DROP sequence seq_customers;
CREATE SEQUENCE seq_customers INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_customers CASCADE CONSTRAINTS;
  CREATE TABLE ce_customers
    (
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
  GRANT SELECT ON bl_3nf.seq_customers TO bl_cl;
  GRANT SELECT, INSERT, DELETE, UPDATE ON ce_customers TO bl_cl;
  ALTER TABLE ce_customers ADD CONSTRAINT ce_customers_pk PRIMARY KEY (customer_id);
  GRANT SELECT ON ce_customers to bl_cl_dm;