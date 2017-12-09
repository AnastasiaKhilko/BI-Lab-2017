-- CLS_PRODUCT_TYPES.
DROP TABLE cls_product_types;
CREATE TABLE cls_product_types
  (
    product_type_id       VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_type_name     VARCHAR2 ( 200 CHAR ) DEFAULT 'NO TYPE',
    category_id VARCHAR2 ( 200 CHAR ) ,
    start_dt      DATE DEFAULT '01-JAN-1990',
    end_dt        DATE DEFAULT '31-DEC-9999',
    is_active     VARCHAR2 ( 200 CHAR ) NOT NULL
  );