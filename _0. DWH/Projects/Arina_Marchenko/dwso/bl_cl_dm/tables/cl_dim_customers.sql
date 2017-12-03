  DROP TABLE cl_dim_customers CASCADE CONSTRAINTS;
  CREATE TABLE cl_dim_customers
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
  GRANT SELECT ON cl_dim_customers TO bl_dm;
  