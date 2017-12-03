DROP TABLE wrk_shops;
CREATE TABLE wrk_shops
  (
    shop_id   NUMBER ( 10 ) NOT NULL,
    shop_name VARCHAR2 ( 200 )  NOT NULL ,
    phone     VARCHAR2 ( 200)  DEFAULT ON NULL 'not defined',
    email     VARCHAR2 ( 200)  DEFAULT ON NULL 'not defined',
    address   VARCHAR2 ( 200 )  DEFAULT ON NULL 'not defined',
    country   VARCHAR2 ( 200 )  NOT NULL,
    city      VARCHAR2 ( 200 )  NOT NULL
  );