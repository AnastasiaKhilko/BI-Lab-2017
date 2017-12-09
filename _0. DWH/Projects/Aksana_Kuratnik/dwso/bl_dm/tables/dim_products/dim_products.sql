--DIM_PRODUCTS.
DROP TABLE dim_products;
CREATE TABLE dim_products(
    product_surr_id     NUMBER(38) NOT NULL,
    product_id          NUMBER(38) NOT NULL,
    product_name       VARCHAR2(100 BYTE) NOT NULL,
    category_name     VARCHAR2(100 BYTE) NOT NULL,
    product_type        VARCHAR2(100 BYTE) NOT NULL,
    price               NUMBER(38),
    start_dt            DATE DEFAULT '01-JAN-1990',
    end_dt              DATE DEFAULT '31-DEC-9999',
    is_active           VARCHAR2 ( 200 CHAR ) NOT NULL,
    CONSTRAINT product_surr_id_pk PRIMARY KEY (product_surr_id)
)
;