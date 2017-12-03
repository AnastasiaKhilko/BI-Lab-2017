DROP TABLE cl_customers;
CREATE TABLE cl_customers
  (
    customer_code NUMBER ( 38 ) NOT NULL,
    name          VARCHAR2 ( 200 ) NOT NULL,
    surname       VARCHAR2 ( 200 ) NOT NULL,
    age           NUMBER(6) NOT NULL,
    gender        VARCHAR2 ( 200 ) NOT NULL,
    phone         VARCHAR2(200) NOT NULL,
    email         VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_customers TO bl_3nf;