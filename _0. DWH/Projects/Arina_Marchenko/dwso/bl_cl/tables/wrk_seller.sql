DROP TABLE wrk_seller;
CREATE TABLE wrk_seller
  (
    seller_id NUMBER ( 10 ) NOT NULL,
    name      VARCHAR2 ( 200 ) NOT NULL,
    surname   VARCHAR2 ( 200 ) NOT NULL,
    address   VARCHAR2 ( 200 ) DEFAULT ON NULL 'not defined',
    city      VARCHAR2 ( 200 ) DEFAULT ON NULL 'not defined',
    state     VARCHAR2 ( 200 ) DEFAULT ON NULL 'not defined',
    country   VARCHAR2 ( 200 ) DEFAULT ON NULL 'not defined',
    email     VARCHAR2(200) DEFAULT ON NULL 'not defined',
    phone     VARCHAR2(200) DEFAULT ON NULL 'not defined'
  );