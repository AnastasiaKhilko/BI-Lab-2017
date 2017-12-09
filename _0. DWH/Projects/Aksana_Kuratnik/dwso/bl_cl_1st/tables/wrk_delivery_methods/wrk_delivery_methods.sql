-- WRK_DELIVERY_METHODS.
DROP TABLE wrk_delivery_methods;
CREATE TABLE wrk_delivery_methods
  (
    delivery_method    VARCHAR2 ( 200 CHAR ) NOT NULL,
    start_dt          DATE DEFAULT '01-JAN-1990',
    end_dt            DATE DEFAULT '31-DEC-9999',
    is_active         VARCHAR2 ( 200 CHAR ) NOT NULL
  );