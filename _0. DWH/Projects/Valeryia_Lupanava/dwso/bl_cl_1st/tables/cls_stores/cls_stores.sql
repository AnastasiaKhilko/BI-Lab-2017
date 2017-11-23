-- CLS_STORES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_stores', object_type => 'table');
END;

CREATE TABLE cls_stores
  (
    store_id   VARCHAR2 ( 200 CHAR ) NOT NULL,
    store_name VARCHAR2 ( 200 CHAR ) NOT NULL,
    manager_id VARCHAR2 ( 200 CHAR ) NOT NULL,
    phone      VARCHAR2 ( 200 CHAR ) NOT NULL,
    address    VARCHAR2 ( 200 CHAR ) NOT NULL,
    city_id    NUMBER (10 ) NOT NULL
  );