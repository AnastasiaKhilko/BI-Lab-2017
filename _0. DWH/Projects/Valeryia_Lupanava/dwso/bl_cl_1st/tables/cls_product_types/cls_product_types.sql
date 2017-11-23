-- CLS_PRODUCT_TYPES.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_product_types', object_type => 'table');
END;

CREATE TABLE cls_product_types
  (
    product_type_id    NUMBER ( 38 ) NOT NULL,
    product_type  VARCHAR2 ( 200 CHAR ) NOT NULL
  );