-- WRK_PRODUCTS.
DROP TABLE wrk_products;
CREATE TABLE wrk_products
(
    product_id      VARCHAR2 ( 200 CHAR ),
    product_name    VARCHAR2 ( 1000 CHAR ),
    category_name   VARCHAR2 ( 200 CHAR ),
    product_type    VARCHAR2 ( 200 CHAR ),
    price           VARCHAR2 ( 200 CHAR ),
    raiting         VARCHAR2 ( 200 CHAR ),
    balance         VARCHAR2 ( 200 CHAR ),
    start_dt        DATE,
    end_dt          DATE,
    is_active       VARCHAR2 ( 100 BYTE )
);