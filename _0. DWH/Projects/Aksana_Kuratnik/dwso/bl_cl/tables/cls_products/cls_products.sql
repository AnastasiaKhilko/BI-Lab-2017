-- CLS_PRODUCTS.  
DROP TABLE cls_products;
CREATE TABLE cls_products
  (
    product_id      VARCHAR2 ( 200 CHAR ) NOT NULL,
    product_name    VARCHAR2 ( 1000 CHAR ) NOT NULL,
    product_type_id VARCHAR2 ( 200 CHAR ),
    start_dt        DATE DEFAULT '01-JAN-1990',
    end_dt          DATE DEFAULT '31-DEC-9999',
    is_active       VARCHAR2 ( 200 CHAR ) NOT NULL
  );