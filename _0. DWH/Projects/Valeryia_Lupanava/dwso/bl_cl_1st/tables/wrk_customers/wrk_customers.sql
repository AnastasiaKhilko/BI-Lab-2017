-- WRK_CUSTOMERS.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_customers', object_type => 'table');
END;

CREATE TABLE wrk_customers
  (
    passport_number VARCHAR2 ( 200 CHAR ),
    first_name      VARCHAR2 ( 200 CHAR ),
    last_name       VARCHAR2 ( 200 CHAR ),
    gender          VARCHAR2 ( 200 CHAR ),
    age             NUMBER ( 38 ),
    email           VARCHAR2 ( 200 CHAR ),
    phone           VARCHAR2 ( 200 CHAR ),
    address         VARCHAR2 ( 200 CHAR ),
    city            VARCHAR2 ( 200 CHAR ),
    country_id      VARCHAR2 ( 200 CHAR ),
    is_active       VARCHAR2 ( 200 CHAR )
  );