-- EXT_PRODUCTS.
DROP TABLE ext_products;
CREATE TABLE ext_products
  (
    product_id      VARCHAR2 ( 300 CHAR ),
    product_name    VARCHAR2 ( 300 BYTE ),
    category_name       VARCHAR2 ( 300 CHAR ),
    product_type    VARCHAR2 ( 300 CHAR ),
    price           VARCHAR2 ( 300 CHAR ),
    raiting           VARCHAR2 ( 200 CHAR ),
    balance         VARCHAR2 ( 300 CHAR ),
    start_dt        DATE,
    end_dt          DATE,
    is_active       VARCHAR2 ( 300 CHAR )
  )
    ORGANIZATION EXTERNAL
        (TYPE oracle_loader DEFAULT DIRECTORY ext_sources
                         ACCESS PARAMETERS (fields terminated BY ',')
                         LOCATION ('products.csv')
    )
    REJECT LIMIT UNLIMITED;