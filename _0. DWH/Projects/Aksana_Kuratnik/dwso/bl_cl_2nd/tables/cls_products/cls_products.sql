--CLS_PRODUCTS.
DROP TABLE cls_products;
CREATE TABLE cls_products(
    product_surr_id     NUMBER(38) NOT NULL,
    product_id          VARCHAR2(100 CHAR) NOT NULL,
    product_name       VARCHAR2(100 CHAR) NOT NULL,
    category_name     VARCHAR2(200 CHAR) NOT NULL,
    product_type        VARCHAR2(200 CHAR) NOT NULL,
    price               NUMBER(38),
    start_dt            DATE DEFAULT '01-JAN-1990',
    end_dt              DATE DEFAULT '31-DEC-9999',
    is_active           VARCHAR2 ( 200 CHAR ) NOT NULL
)
;