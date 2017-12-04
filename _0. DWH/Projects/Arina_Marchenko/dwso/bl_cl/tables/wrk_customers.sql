drop table wrk_customers;

CREATE TABLE wrk_customers
  (
    customer_id NUMBER ( 38 ) not null,
    name  VARCHAR2 ( 200 ) not null,
    surname   VARCHAR2 ( 200 ) not null,
    age         number(6) DEFAULT ON NULL '-198',
    gender      VARCHAR2 ( 200 ) DEFAULT ON NULL 'not defined',
    phone       VARCHAR2(200) DEFAULT ON NULL 'not defined',
    email       VARCHAR2(200)DEFAULT ON NULL 'not defined'
  );