-- WRK_PRODUCTS.
BEGIN
  pkg_drop.drop_proc(object_name => 'wrk_products', object_type => 'table');
END;

CREATE TABLE wrk_products
(
    product_id      VARCHAR2 ( 200 CHAR ),
    product_name    VARCHAR2 ( 200 CHAR ),
    line_name       VARCHAR2 ( 200 CHAR ),
    collection_name VARCHAR2 ( 200 CHAR ),
    product_type    VARCHAR2 ( 200 CHAR ),
    color           VARCHAR2 ( 200 CHAR ),
    panty_size_id   VARCHAR2 ( 200 CHAR ),
    price           VARCHAR2 ( 200 CHAR ),
    balance         VARCHAR2 ( 200 CHAR )
);