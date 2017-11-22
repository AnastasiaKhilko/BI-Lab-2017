-- CLS_CUSTOMERS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_customers', object_type => 'table');
END;

CREATE TABLE cls_customers
  (
    customer_id      VARCHAR2 ( 200 CHAR ) NOT NULL,
    first_name       VARCHAR2 ( 200 CHAR ) NOT NULL,
    last_name        VARCHAR2 ( 200 CHAR ) NOT NULL,
    age              NUMBER ( 38 ) NOT NULL,
    age_category_id  NUMBER ( 38 ) NOT NULL,
    email            VARCHAR2 ( 200 CHAR ) NOT NULL,
    phone            VARCHAR2 ( 200 CHAR ) NOT NULL,
    address          VARCHAR2 ( 200 CHAR ) NOT NULL,
    city_id          VARCHAR2 ( 200 CHAR ) NOT NULL
  );