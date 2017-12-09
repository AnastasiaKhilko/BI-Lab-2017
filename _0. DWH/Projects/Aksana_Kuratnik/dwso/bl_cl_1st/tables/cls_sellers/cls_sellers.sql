-- CLS_SELLERS.
DROP TABLE cls_sellers;
CREATE TABLE cls_sellers
  (
    seller_id  VARCHAR2 ( 200 CHAR ) NOT NULL,
    first_name VARCHAR2 ( 200 CHAR ) NOT NULL,
    last_name  VARCHAR2 ( 200 CHAR ) NOT NULL,
    gender     VARCHAR2 ( 200 CHAR ) NOT NULL,
    age        VARCHAR2 ( 40 CHAR ) NOT NULL,
    email      VARCHAR2 ( 200 CHAR ) NOT NULL,
    phone      VARCHAR2 ( 200 CHAR ) NOT NULL,
    address    VARCHAR2 ( 200 CHAR ) NOT NULL,
    city_id    VARCHAR2 ( 200 CHAR ) NOT NULL,
    start_dt   DATE DEFAULT '01-JAN-1990',
    end_dt     DATE DEFAULT '31-DEC-9999',
    is_active  VARCHAR2 ( 200 CHAR ) NOT NULL
  );