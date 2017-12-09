--WRK_ MANUFACTURERS
DROP TABLE wrk_manufacturers;
CREATE TABLE wrk_manufacturers
  (
    manufacturer_code   VARCHAR2 ( 200 CHAR ) NOT NULL,
    manufacturer_name   VARCHAR2 ( 200 CHAR ),
    phone        VARCHAR2 ( 200 CHAR ) NOT NULL,
    address      VARCHAR2 ( 200 CHAR ) NOT NULL,
    city      VARCHAR2 ( 200 CHAR ) NOT NULL,
    country_id   VARCHAR2 ( 200 CHAR ) NOT NULL,
    insert_dt    DATE DEFAULT '01-JAN-1990'
  );