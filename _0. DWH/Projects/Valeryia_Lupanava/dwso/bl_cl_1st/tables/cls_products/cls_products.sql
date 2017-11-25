-- CLS_PRODUCTS.
BEGIN
  pkg_drop.drop_proc(object_name => 'cls_products', object_type => 'table');
END;

CREATE TABLE cls_products
  (
    product_id      NUMBER ( 38 ) NOT NULL,
    product_ein     VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_name    VARCHAR2 ( 200 CHAR ) NOT NULL,
    line_id         NUMBER ( 38 ) NOT NULL,
    product_type_id NUMBER ( 38 ) NOT NULL,
    start_dt        DATE DEFAULT '01-JAN-1990',
    end_dt          DATE DEFAULT '31-DEC-9999',
    is_active       VARCHAR2 ( 200 CHAR ) NOT NULL
  );